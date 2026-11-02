# Dorothy User Configuration

This is Mike Crowe's user configuration for the [Dorothy](https://github.com/bevry/dorothy) dotfile ecosystem.

## New Machine Setup

### 1. Install Dorothy

```bash
bash -c "$(curl -fsSL https://dorothy.bevry.me/install)"
```

During install, when prompted for a user config repo, enter:

```
https://github.com/drmikecrowe/dorothy-config
```

### 2. Apply dotfiles via chezmoi

```bash
export GITHUB_USERNAME=drmikecrowe
setup-util-chezmoi
```

This installs [chezmoi](https://www.chezmoi.io) and applies dotfiles from [drmikecrowe/dotfiles](https://github.com/drmikecrowe/dotfiles).

### 3. Decrypt the `*.local` files

Everything under `config.local/` and `commands.local/` is committed encrypted by [strongbox](https://github.com/uw-labs/strongbox) (see `.gitattributes`). Copy `~/.strongbox_keyring` from a machine that has it (it is not in this repo), then:

```bash
strongbox -git-config                          # register the git filters
strongbox -decrypt -recursive ~/.config/dorothy  # decrypt the existing checkout
```

### 4. 1Password secrets in the login environment

Login shells get selected 1Password values (for example `OPENBRAIN_URL`) as exported variables, so `claude` and other MCP clients see them. [varlock](https://varlock.dev)'s 1Password plugin resolves them and keeps an encrypted cache for `cacheTtl`, so 1Password asks for approval about once per TTL, not once per shell. No plaintext value is written to disk.

The pieces:

| File | In this repo? | Role |
| --- | --- | --- |
| `~/.config/secrets/.env.schema` | No, one per machine | Which keys to load, as `op://` references |
| `commands.local/secrets-env` | Yes, encrypted | Resolves the schema and prints `declare -x` lines |
| `config.local/interactive.sh` | Yes, encrypted | Evals `secrets-env` once per shell, when `OPENBRAIN_URL` is unset |

The schema is per machine, so each machine can load different secrets from different vaults.

To set up a machine:

1. Install the CLIs and sign in: `mise use -g npm:varlock`, install the 1Password app and CLI, then turn on CLI integration in the app (Settings > Developer). Check with `op account list`.
2. Create `~/.config/secrets/.env.schema`. Use `op item get <item> --format json` to find the vault, item, and field names.

   ```bash
   # @defaultSensitive=true @defaultRequired=true
   # @plugin(@varlock/1password-plugin@1.2.0)
   # @initOp(allowAppAuth=true, cacheTtl=8h)
   # ---
   OPENBRAIN_URL=op("op://Private/OPENBRAIN_URL/url")
   BRAVE_API_KEY=op("op://Private/BRAVE_API_KEY/credential")
   ```

   The plugin must have a fixed version, or varlock refuses to load it.
3. Verify:

   ```bash
   varlock load --path ~/.config/secrets    # every key resolves (values redacted)
   secrets-env | cut -d= -f1                # one `declare -x NAME` line per key
   varlock cache status                     # shows 1password-plugin entries
   ```

4. Open a new terminal. Check `echo ${OPENBRAIN_URL:+set}`, then restart any `claude` sessions that were already running.

Notes:

- Only put keys in the schema that every process may read. Install scripts, such as npm `postinstall`, can read your login environment. Keep publish tokens, cloud credentials, and passphrases out, and load them per command with `varlock run --path <dir> -- <cmd>`.
- On Linux, the loader also copies the keys into the systemd user manager, so apps launched under uwsm inherit them. After a new login, open a terminal before you start GUI clients. On macOS the `systemctl` line fails silently, and GUI apps do not get the keys.
- `secrets-env` needs bash 4 or newer first in `PATH`. macOS `/bin/bash` is 3.2.
- After you add a key, run `systemctl --user unset-environment OPENBRAIN_URL` (Linux) and open a new terminal, because the loader skips shells that already have `OPENBRAIN_URL`.
- If 1Password is locked when the cache expires, the loader fails silently and that shell has no keys. Unlock 1Password and open a new terminal.

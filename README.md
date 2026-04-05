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

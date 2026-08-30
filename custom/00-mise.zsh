# Mise runtime manager for Zsh
if command -v mise > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
    # Write completion to fpath so it survives compinit resets (e.g. from carapace)
    local _mise_comp_dir="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/completions"
    local _mise_comp_stamp="$_mise_comp_dir/.mise-version"
    local _mise_version="${${(z)$(mise --version)}[1]}"
    mkdir -p "$_mise_comp_dir"
    # Regenerate when mise is upgraded, else a stale _mise breaks `mise run <tab>`
    if [[ ! -f "$_mise_comp_dir/_mise" || "$(cat "$_mise_comp_stamp" 2>/dev/null)" != "$_mise_version" ]]; then
        local _mise_comp_tmp="$_mise_comp_dir/_mise.$$"
        # The generated completion appends each task description in full, so a task documented in
        # a few hundred chars blows past $COLUMNS and the listing layout collapses. Clamp each
        # description to the space left on the row.
        #
        # usage-cli renames the locals in this template between releases (2026.8.10 -> 2026.8.12
        # took _usage_display/descs to display/descriptions), so match the row-building line by
        # shape and lift the array names out of it rather than hardcoding them. If the shape goes
        # away too, the match count drops and we keep the previous _mise instead of a broken one.
        if mise completion zsh 2>/dev/null | awk '
            function between(s, a, b,   p, q, r) {
                p = index(s, a); if (p == 0) return ""
                r = substr(s, p + length(a))
                q = index(r, b); if (q == 0) return ""
                return substr(r, 1, q - 1)
            }
            /\+=\("\$\{/ && /\$\{\(l:/ && / -- \$\{/ {
                match($0, /^[ \t]*/); ind = substr($0, 1, RLENGTH)
                val = between($0, "(\"${", "}${(")
                pad = between($0, "${(l:", "::")
                dsc = between($0, " -- ${", "}\")")
                if (val != "" && pad != "" && dsc != "") {
                    print ind "local __uc_w=$(( COLUMNS - ${#" val "} - " pad " - 7 ))"
                    print ind "(( __uc_w < 20 )) && __uc_w=20"
                    # Split via a named array: ${${(f)arr[i]}[1]} subscripts the string by
                    # character, not by line, when the inner expansion is an array element.
                    print ind "local -a __uc_l=( \"${(@f)" dsc "}\" )"
                    print ind dsc "=\"${__uc_l[1]}\""
                    print ind "(( ${#" dsc "} > __uc_w )) && " dsc "=\"${" dsc "[1,__uc_w-1]}…\""
                    n++
                }
            }
            { print }
            END { if (n != 1) exit 3 }
        ' > "$_mise_comp_tmp"; then
            mv -f "$_mise_comp_tmp" "$_mise_comp_dir/_mise" \
                && print -r -- "$_mise_version" > "$_mise_comp_stamp"
        else
            print -ru2 -- "00-mise.zsh: mise $_mise_version completion no longer matches the description-clamp patch; keeping previous _mise"
            rm -f "$_mise_comp_tmp"
        fi
    fi
    fpath=("$_mise_comp_dir" $fpath)
    compdef _mise mise 2>/dev/null || true
fi

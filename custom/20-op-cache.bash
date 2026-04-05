# 1Password variable caching for Bash
# Usage: cache-op-var VARNAME
# Resolves op:// references and caches the result

declare -A _op_cache

cache-op-var() {
    local var_name="$1"
    local var_value="${!var_name}"

    # If not an op:// reference, nothing to do
    [[ "$var_value" != op://* ]] && return 0

    # Check cache
    if [[ -n "${_op_cache[$var_name]:-}" ]]; then
        export "$var_name"="${_op_cache[$var_name]}"
        return 0
    fi

    # Resolve and cache
    local resolved
    if resolved=$(op-resolve "$var_value"); then
        _op_cache[$var_name]="$resolved"
        export "$var_name"="$resolved"
    else
        echo "cache-op-var: Failed to resolve $var_name" >&2
        return 1
    fi
}

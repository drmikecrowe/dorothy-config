# 1Password helper for Zsh
# Provides load/unload/status functions for op:// environment variables

load-1password() {
    # Find all exported env vars containing op:// (use env command for safety)
    local -a op_names
    local -a op_values
    local name value

    while IFS='=' read -r name value; do
        [[ "$value" == *'op://'* ]] || continue
        op_names+=("$name")
        op_values+=("$value")
    done < <(env)

    if (( ${#op_names} == 0 )); then
        echo "No op:// references found in environment"
        return
    fi

    # Store originals for unload (name|value pairs)
    # Use newline as separator (pipe separates name from value)
    local -a originals
    local i
    for ((i=1; i<=${#op_names}; i++)); do
        originals+=("${op_names[$i]}|${op_values[$i]}")
    done
    export __OP_ORIGINAL__="${(j:\n:)originals}"

    # Build template and inject
    local template=""
    for ((i=1; i<=${#op_names}; i++)); do
        template+="${op_names[$i]}=${op_values[$i]}"$'\n'
    done

    local decoded
    decoded=$(printf '%s' "$template" | op inject)

    # Update environment with decoded values
    local line
    while IFS= read -r line; do
        [[ -n "$line" ]] || continue
        local vname="${line%%=*}"
        local vvalue="${line#*=}"
        typeset -gx "$vname"="$vvalue"
    done <<< "$decoded"

    local count=${#op_names}
    echo "Loaded $count secrets from 1Password"
}

unload-1password() {
    if [[ -z "${__OP_ORIGINAL__:-}" ]]; then
        echo "No 1Password secrets currently loaded"
        return
    fi

    # Restore original op:// references
    local -a originals
    originals=("${(@s:\n:)__OP_ORIGINAL__}")

    local entry name value
    for entry in "${originals[@]}"; do
        name="${entry%%|*}"
        value="${entry#*|}"
        typeset -gx "$name"="$value"
    done

    # Clean up
    unset __OP_ORIGINAL__

    echo "Restored ${#originals} op:// references"
}

op-status() {
    if [[ -n "${__OP_ORIGINAL__:-}" ]]; then
        local -a originals
        originals=("${(@s:\n:)__OP_ORIGINAL__}")
        echo "1Password secrets loaded: ${#originals} variables"
        local entry
        for entry in "${originals[@]}"; do
            echo "  ${entry%%|*}"
        done
    else
        local -a op_names
        local name value
        while IFS='=' read -r name value; do
            [[ "$value" == *'op://'* ]] || continue
            op_names+=("$name")
        done < <(env)
        echo "1Password secrets not loaded: ${#op_names} op:// references found"
        for name in "${op_names[@]}"; do
            echo "  $name"
        done
    fi
}

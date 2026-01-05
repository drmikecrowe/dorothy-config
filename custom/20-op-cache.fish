# 1Password variable caching for Fish
# Usage: cache-op-var VARNAME
# Resolves op:// references and caches the result

set -g _op_cache_keys
set -g _op_cache_values

function cache-op-var
    set -l var_name $argv[1]
    set -l var_value $$var_name

    # If not an op:// reference, nothing to do
    if not string match -q 'op://*' "$var_value"
        return 0
    end

    # Check cache
    set -l idx (contains -i -- $var_name $_op_cache_keys)
    if test -n "$idx"
        set -gx $var_name $_op_cache_values[$idx]
        return 0
    end

    # Resolve and cache
    set -l resolved (op-resolve "$var_value")
    if test $status -eq 0
        set -a _op_cache_keys $var_name
        set -a _op_cache_values $resolved
        set -gx $var_name $resolved
    else
        echo "cache-op-var: Failed to resolve $var_name" >&2
        return 1
    end
end

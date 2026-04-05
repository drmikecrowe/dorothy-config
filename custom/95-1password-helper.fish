# 1Password helper for Fish
# Provides load/unload/status functions for op:// environment variables

# Store original op:// values for later restoration
function load-1password
    # Find all env vars containing op://
    set -l op_names
    set -l op_values

    for name in (set -nx)
        if string match -qr 'op://' -- $$name
            set -a op_names $name
            set -a op_values $$name
        end
    end

    if test -z "$op_names"
        echo "No op:// references found in environment"
        return
    end

    # Store originals for unload (as newline-separated name|value pairs)
    set -l originals
    for i in (seq (count $op_names))
        set -a originals "$op_names[$i]|$op_values[$i]"
    end
    set -gx __OP_ORIGINAL__ (string join '\n' $originals)

    # Build template and inject
    set -l template
    for i in (seq (count $op_names))
        set -a template "$op_names[$i]=$op_values[$i]"
    end
    set -l decoded (string join '\n' $template | op inject)

    # Update environment with decoded values
    for line in (string split '\n' $decoded)
        if test -n "$line"
            set -l parts (string split -m 1 '=' $line)
            if test (count $parts) -eq 2
                set -gx $parts[1] $parts[2]
            end
        end
    end

    set -l count (string split '\n' $decoded | string match -r '.*' | count)
    echo "Loaded $count secrets from 1Password"
end

function unload-1password
    if not set -q __OP_ORIGINAL__
        echo "No 1Password secrets currently loaded"
        return
    end

    # Restore original op:// references
    set -l originals (string split '\n' $__OP_ORIGINAL__)

    for entry in $originals
        set -l parts (string split -m 1 '|' $entry)
        if test (count $parts) -eq 2
            set -gx $parts[1] $parts[2]
        end
    end

    # Clean up
    set -e __OP_ORIGINAL__

    echo "Restored "(count $originals)" op:// references"
end

function op-status
    if set -q __OP_ORIGINAL__
        set -l originals (string split '\n' $__OP_ORIGINAL__)
        echo "1Password secrets loaded: "(count $originals)" variables"
        for entry in $originals
            set -l parts (string split '|' $entry)
            echo "  $parts[1]"
        end
    else
        set -l op_names
        for name in (set -nx)
            if string match -qr 'op://' -- $$name
                set -a op_names $name
            end
        end
        echo "1Password secrets not loaded: "(count $op_names)" op:// references found"
        for name in $op_names
            echo "  $name"
        end
    end
end

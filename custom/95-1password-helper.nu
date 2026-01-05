# Store original op:// values for later restoration
def --env load-1password [] {
    # Find all env vars containing op:// (filter to strings first)
    let op_vars = ($env
        | transpose name value
        | where { ($in.value | describe) == "string" and ($in.value | str contains "op://") }
    )

    if ($op_vars | is-empty) {
        print "No op:// references found in environment"
        return
    }

    # Store originals for unload
    $env.__OP_ORIGINAL__ = ($op_vars | to nuon)

    # Build template and inject
    let template = ($op_vars | each { $"($in.name)=($in.value)" } | str join "\n")
    let decoded = ($template | ^op inject | lines | parse "{name}={value}")

    # Update environment with decoded values
    for row in $decoded {
        load-env { ($row.name): $row.value }
    }

    print $"Loaded ($decoded | length) secrets from 1Password"
}

def --env unload-1password [] {
    if not ("__OP_ORIGINAL__" in $env) {
        print "No 1Password secrets currently loaded"
        return
    }

    # Restore original op:// references
    let originals = ($env.__OP_ORIGINAL__ | from nuon)

    for row in $originals {
        load-env { ($row.name): $row.value }
    }

    # Clean up
    hide-env __OP_ORIGINAL__

    print $"Restored ($originals | length) op:// references"
}

def --env op-status [] {
    if ("__OP_ORIGINAL__" in $env) {
        let originals = ($env.__OP_ORIGINAL__ | from nuon)
        print $"1Password secrets loaded: ($originals | length) variables"
        $originals | select name
    } else {
        let op_vars = ($env
            | transpose name value
            | where { ($in.value | describe) == "string" and ($in.value | str contains "op://") }
        )
        print $"1Password secrets not loaded: ($op_vars | length) op:// references found"
        $op_vars | select name
    }
}

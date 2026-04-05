def _y(args):
    tmp = $(mktemp -t "yazi-cwd.XXXXXX")
    args.append(f"--cwd-file={tmp}")
    $[yazi @(args)]
    with open(tmp) as f:
        cwd = f.read()
    if cwd != $PWD:
        cd @(cwd)
    rm -f -- @(tmp)

aliases["y"] = _y

# cdd
# cd to directory of ...
# Takes up to 1 argument. cdd without arguments does "cdd !$" (with the
# result of history substitution on "!$" treated as a single word).
#
# By Glenn G. Chappell
# Updated: 2021-05-25
# https://github.com/ggchappell/cdd
function cdd {
    local __CDD_ARG

    # Get the command-line argument, or, if there is none, do history
    # substitution on !$. Store the result in variable __CDD_ARG.
    if (( $# >= 2 )); then
        echo >&2 "$FUNCNAME: Too many arguments"
        return 2
    elif (( $# == 1 )); then
        __CDD_ARG="$1"
    else  # $# == 0: set __CDD_ARG to history expansion of !$
        # Check if history enabled
        if [[ $(set +o) =~ \+o\ history ]]; then
            echo >&2 -n "$FUNCNAME: History expansion failed"
            echo >&2 " (history is disabled)"
            return 1
        fi

        # Do history expansion. Requires history to be enabled.
        if ! __CDD_ARG=$(history -p !$ 2> /dev/null); then
            echo >&2 "$FUNCNAME: History expansion failed"
            return 1
        fi

        # Evaluate $__CDD_ARG. If its value begins with '-', then avoid
        # special treatment by evaluating with ' ' prepended. Otherwise,
        # do not do this, as it prevents tilde expansion.
        if [[ "${__CDD_ARG:0:1}" == '-' ]]; then
            __CDD_ARG=$(eval "unset __CDD_ARG; echo -E ' '$__CDD_ARG")
            __CDD_ARG=${__CDD_ARG:1}
        else
            __CDD_ARG=$(eval "unset __CDD_ARG; echo -E $__CDD_ARG")
        fi
    fi

    # cd to $__CDD_ARG, or, if this fails, to `dirname $__CDD_ARG`.
    if ! cd -- "$__CDD_ARG" 2> /dev/null; then
        local DIR=$(dirname -- "$__CDD_ARG")
        cd -- "$DIR"
        # For the above 'cd' command:
        # - Error messages go to our stderr.
        # - Its exit status is our exit status.
    fi
}


# cdd
# cd to directory of ...
# Takes up to 1 argument. cdd without arguments does "cdd !$" (with the
# result of history substitution on "!$" treated as a single word).
#
# By Glenn G. Chappell
# Updated: 2021-05-25
# https://github.com/ggchappell/cdd
function cdd {
    local ARG

    # Get the command-line argument, or, if there is none, do history
    # substitution on !$. Store the result in variable ARG.
    if (( $# >= 2 )); then
        echo >&2 "$FUNCNAME: Too many arguments"
        return 2
    elif (( $# == 1 )); then
        ARG="$1"
    else  # $# == 0: set ARG to history expansion of !$, if possible
        # Check if history enabled
        if [[ $(set +o) =~ \+o\ history ]]; then
            echo >&2 -n "$FUNCNAME: History expansion failed"
            echo >&2 " (history is disabled)"
            return 1
        fi

        # Do history expansion. Requires history to be enabled.
        if ! ARG=$(history -p !$ 2> /dev/null); then
            echo >&2 "$FUNCNAME: History expansion failed"
            return 1
        fi

        # Evaluate ARG. If its value begins with '-', then avoid special
        # treatment by evaluating with ' ' prepended. Otherwise. do not
        # do this, as it prevents tilde expansion.
        if [[ "${ARG:0:1}" == '-' ]]; then
            ARG=$(eval "echo -E ' '$ARG")
            ARG=${ARG:1}
        else
            ARG=$(eval "echo -E $ARG")
        fi
    fi

    # cd to $ARG, or, if this fails, to the result of "dirname $ARG".
    if ! cd -- "$ARG" 2> /dev/null; then
        local DIR=$(dirname -- "$ARG")
        cd -- "$DIR"
        # For the above 'cd' command:
        # - Error messages go to our stderr.
        # - Its exit status is our exit status.
    fi
}


# cdd
# cd to directory of ...
# Takes 1 argument. If history is enabled, then cdd without arguments is
# equivalent to cdd !$ (with "!$" in double quotes as necessary).
#
# By Glenn G. Chappell
# Updated: 2021-05-03
# https://github.com/ggchappell/cdd
function cdd {
    local ARG

    # Get the command-line argument, or, if there is none, do history
    # substitution on !$. Store the result in variable ARG.
    if (( $# >= 2 )); then
        echo >&2 "$FUNCNAME: Too many arguments"
        return
    elif (( $# == 1 )); then
        ARG="$1"
    elif [[ $(set +o) =~ \+o\ history ]]; then  # history disabled
        echo >&2 "$FUNCNAME: History is disabled; argument required"
        return
    else
        # Do history expansion. Requires history to be enabled.
        ARG=$(history -p !$)

        # Emulate normal argument evaluation. To ensure that echo does
        # not treat arguments beginning with '-' specially, prepend ' '
        # and, after evaluation, remove the first character. For other
        # arguments, do not do this, as it prevents tilde expansion.
        if [ ${ARG:0:1} == '-' ]; then
            ARG=$(eval echo -E \' \'$ARG)
            ARG=${ARG:1}
        else
            ARG=$(eval echo -E $ARG)
        fi
    fi

    # cd to $ARG, or, if this fails, to the result of "dirname $ARG".
    if ! cd -- "$ARG" 2> /dev/null; then
        local DIR=$(dirname -- "$ARG")
        cd -- "$DIR"
        # Error messages from the above cd command go to stderr.
    fi
}


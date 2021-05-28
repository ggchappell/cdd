# cdd
# cd to directory of ...
# Takes up to 1 argument. cdd without arguments takes its argument from
# the last argument of the previous command.
#
# By Glenn G. Chappell
# Updated: 2021-05-28
# https://github.com/ggchappell/cdd
function cdd {
    # Get last argument of previous command.
    local ARG="$_"

    # If there is a single command-line argument, then replace the value
    # of ARG with that.
    if (( $# >= 2 )); then
        echo >&2 "$FUNCNAME: Too many arguments"
        return 2
    elif (( $# == 1 )); then
        ARG="$1"
    fi

    # cd to $ARG, or, if this fails, to the result of 'dirname $ARG'.
    if ! cd -- "$ARG" 2> /dev/null; then
        local DIR=$(dirname -- "$ARG")
        cd -- "$DIR"
        # For the above 'cd' command:
        # - Error messages go to our stderr.
        # - Its exit status is our exit status.
    fi
}


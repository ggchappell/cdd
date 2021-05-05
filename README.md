# cdd

## Description

`cdd` (cd to directory of ...) is a Bash command. It does a `cd` to the
last argument on the previous command line, or, if this is not a
directory, it does a `cd` to the directory it lies in.

For example, after a `mv` or `cp` command, doing `cdd` takes you to the
directory of the destination file(s).

    ~/xyz$ cp file1 file2 file3 abc/def
    ~/xyz$ cdd
    ~/xyz/abc/def$

    ~/xyz$ mv file4 ~/ghi/jkl/fffff.ggg
    ~/xyz$ cdd
    ~/ghi/jkl$

More fully, `cdd` performs as follows.

First, if `cdd` is given a command-line argument that is an accessible
directory, then it does a `cd` to that directory.

    ~/xyz$ cdd abc
    ~/xyz/abc$

Second, if `cdd` is given a command-line argument that is not a
directory, then it does a `cd` to the directory that the file lies in.

    ~/xyz$ cdd abc/source.c
    ~/xyz/abc$

Third, if `cdd` is not given a command-line argument, then it obtains
its argument by doing a history substitution on `!$`, that is, the last
argument of the previous command.

    ~/xyz$ echo "Howdy"
    ~/xyz$ cdd
    ~/xyz/Howdy$

## Installation

`cdd` is written as a Bash function. The source code is file
[`cdd.sh`](cdd.sh).

To make the `cdd` command available, add the contents of file
[`cdd.sh`](cdd.sh) to your `.bashrc`, or to some file `source`d by
your `.bashrc` (for example, `.bash_aliases`, if you have such a file).
`cdd` can then be used on the command line in any new interactive Bash
shell.

## Authorship & License

By Glenn G. Chappell.
Public domain (Unlicense).
See [`LICENSE`](LICENSE).


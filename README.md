# cdd

## Description

`cdd` (cd to directory of ...) is a Bash command.
After a `mv` or `cp` command, doing `cdd` takes you to the directory of
the destination file(s).

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

`cdd` is written as a Bash function.

To make the `cdd` command available, `source` the file
[`cdd.sh`](cdd.sh).
Then `cdd` can be used on the Bash command line.

To make `cdd` available permanently, either `source` file `cdd.sh` in
your `.bashrc`, or append the contents of [`cdd.sh`](cdd.sh) to your
`.bashrc` or some file `source`d by this (for example, `.bash_aliases`,
if you have such a file).

## Authorship & License

By Glenn G. Chappell.
Public domain (Unlicense).
See [`LICENSE`](LICENSE).


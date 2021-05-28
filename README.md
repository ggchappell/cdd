# cdd

A Bash command. `cdd` = cd to directory of ....

## Usage

Many \*ix shell commands take a final argument that is a destination
directory or file. `cdd` after such a command sets the working directory
to the destination directory or the directory holding the destination
file(s), as appropriate.

`cdd` is particularly useful after a `mv` or `cp` command.

    ~/xyz$ cp file1 file2 file3 abc/def
    ~/xyz$ cdd
    ~/xyz/abc/def$

    ~/xyz$ mv source.c ~/ghi/jkl/main.c
    ~/xyz$ cdd
    ~/ghi/jkl$

More fully, `cdd` performs as follows.

First, if `cdd` is given a command-line argument that is an accessible
directory, then it does a `cd` to that directory.

    ~/xyz$ cdd images
    ~/xyz/images$

Second, if `cdd` is given a command-line argument that is not a
directory but is a file, then it does a `cd` to the directory that the
file lies in.

    ~/xyz$ cdd images/qq.jpg
    ~/xyz/images$

Third, if `cdd` is not given a command-line argument, then it obtains
its argument from the last argument of the previous command.

    ~/xyz$ convert qq.png images/qq.jpg
    ~/xyz$ cdd
    ~/xyz/images$

## Installation

`cdd` is written as a Bash function. The source code is file
[`cdd.bash`](cdd.bash).

To make the `cdd` command available, add the contents of file
[`cdd.bash`](cdd.bash) to your `.bashrc`, or to some file `source`d by
your `.bashrc` (for example, `.bash_aliases`, if you have such a file).
`cdd` can then be used on the command line in any new interactive Bash
shell.

## Authorship & License

By Glenn G. Chappell.
Public domain (Unlicense).
See [`LICENSE`](LICENSE).


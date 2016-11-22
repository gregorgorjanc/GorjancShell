# Gorjanc Shell
Gregor Gorjanc's (bash) shell functions and scripts

## Description

A set of functions and scripts that make my life easier when working in shell/terminal. These are not necesarilly bomb proof, but do the job. Feel free to improve them!

The functions/scripts are:
  * [cpumemlog](README_cpumemlog.md) - monitor CPU and RAM usage
  * [cwdiff](cwdiff) - color word diff
  * [browse](func_browse.sh) - open file browser application from working folder
  * [dim,nrow,ncol](func_dim.sh) - number of rows and columns in an rectangular file
  * [find*](func_find.sh) - find files and folders quickly
  * [func](func_func.sh) - print out a function
  * [hi](func_hi.sh) - search in the .history file
  * [open](func_open.sh) - my attempt at generic file opener from the terminal
  * [psu,psux](func_psu.sh) - find user's processes and where they are running
  * [remove_header](func_remove_header.sh) - remove first row in a file
  * [repeat](func_repeat.sh) - repeat something
  * [rmd,cld,...](func_rm.sh) - various remove functions
  * [rows,cols](func_rows_cols.sh) - print a subset of rows and cols
  * [see,see_col,head_col,tail_col](func_see.sh) - print few rows of a file
  * [server](func_server.sh) - generate a set of aliases for a set of servers
  * [qstat*,qdelall](func_sge.sh) - manipulate SGE cluster jobs
  * [stop,reboot](func_stop.sh) - stop and reboot computer
  * [sys_info](fuinc_sys_info.sh) - retrieve system information (RAM, processors, disk, ...)
  * [x2y](func_x2y.sh) - convert files from one type to another
  * [tarc,tarx,zipc,zipx](func_zip.sh) - (un)compress a given folder
  * [grepall](grepall) - grep recursively
  * [pwdx](pwdx) - print working directory of a process
  * [qwc](qwc) - quick wc
  * [spaces](spaces) - replace filename spaces with _

## Installation

Functions are stored in files named *func_foo.sh* while scripts are stored in
files named *foo*.

1. Save the files in your ~/bin folder
2. Add ~/bin folder to your PATH variable, i.e., export PATH=~/bin:$PATH
3. In order to be able to use functions, add the following code to your ~/.bashrc
file for each function you want to use:

```shell
if [ -f ~/bin/func_foo.sh ]; then
  source ~/bin/func_foo.sh
fi
```

or for a set of functions:

```shell
FUNCS="func_foo1.sh
       func_foo2.sh"
for FILE in ${FUNCS}; do
  if [ -f "~/bin/${FILE}" ]; then
    source ~/bin/${FILE}
  fi
done
```

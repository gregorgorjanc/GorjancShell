# cpumemlog
Monitor CPU and RAM usage of a process (and its children)

## Description

**cpumemlog.sh** is a Bash shell script that monitors CPU and RAM usage of a given
process and its children. The main aim for writing this script was to get insight
about the behaviour of a process and to spot bottlenecks without GUI tools, e.g.,
cpumemlog.sh it is very useful to spot that the computationally intensive process
on a remote server died due to hitting RAM limit or something of that sort. The
statistics about CPU, RAM, and all that are gathered from the system utility
[ps](http://man7.org/linux/man-pages/man1/ps.1.html).

While the utility [top](http://www.unixtop.org) can be used for this interactively,
it is tedious to stare at its dynamic output and quite hard to spot consumption at
the peak and follow the trends etc. Yet another similar utility is [time](http://man7.org/linux/man-pages/man1/time.1.html), which though only gives
consumption of resources at the peak.

**cpumemlogplot.R** is a companion [R](http://www.r-project.org) script to cpumemlog.sh
used to summarize and plot the gathered data.

## Usage

To monitor usage of a process, we first need to know its process ID (PID), which
can be found, for example, from the output of the [top](http://www.unixtop.org) or [ps](http://man7.org/linux/man-pages/man1/ps.1.html) utilities. Say, the process
has PID 1234, then we can monitor its CPU and RAM usage with (note the & character
that puts the script into background until the process stops running):

```shell
cpumemlog.sh 1234 &
```

and the gathered data are stored into a file called cpumemlog_1234.txt:

```shell
$ cat cpumemlog_1234.txt
DATE TIME PID PCPU PMEM RSS VSZ ETIME COMMAND
2015-01-13 12:50:31 407021 145 0.0 34260 90592 00:00:00 R
2015-01-13 12:50:32 407021 112 0.0 61416 120492 00:00:02 R
2015-01-13 12:50:35 407021 105 0.0 83856 142848 00:00:04 R
2015-01-13 12:50:37 407021 103 0.0 99616 160680 00:00:06 R
2015-01-13 12:50:39 407021 102 0.0 138516 199744 00:00:08 R
...
```

which can be in turn summarised using:

```shell
cpumemlogplot.R cpumemlog_1234.txt
```

giving something like this:

```shell
RAM - RSS (Gb):
  RSS.n RSS.obs RSS.mean RSS.median   RSS.sd   RSS.cv     RSS.min  RSS.max
1  7265    7265 7.593337    5.62043 8.487768 1.117792 0.001308441 26.22396

RAM - RSS by command (Gb):
   COMMAND RSS.n RSS.obs     RSS.mean   RSS.median       RSS.sd    RSS.cv     RSS.min      RSS.max
1 inla64_1  1933    1933 20.390156834 22.490909576 5.5258271860 0.2710046 0.624172211 26.223964691
2      R_2  3399    3399  4.633348078  5.620429993 1.3917450821 0.3003757 0.032672882  8.115345001
3     sh_3  1933    1933  0.001381518  0.001308441 0.0001989013 0.1439730 0.001308441  0.001922607

CPU:
  PCPU.n PCPU.obs PCPU.mean PCPU.median  PCPU.sd   PCPU.cv PCPU.min PCPU.max
1   7265     7265  86.38191        78.1 76.24002 0.8825924        0      244

CPU by command:
   COMMAND PCPU.n PCPU.obs    PCPU.mean PCPU.median     PCPU.sd    PCPU.cv PCPU.min PCPU.max
1 inla64_1   1933     1933 1.946210e+02       195.0 34.91599492  0.1794051     99.2    244.0
2      R_2   3399     3399 7.395069e+01        78.1 25.85870283  0.3496749     33.6    145.0
3     sh_3   1933     1933 1.965856e-03         0.0  0.07752823 39.4373855      0.0      3.4

TIME:
             TIME.min            TIME.max      TIME.diff
1 2015-01-13 12:50:31 2015-01-13 15:17:16 2.445833 hours

TIME by command:
   COMMAND            TIME.min            TIME.max      TIME.diff
1 inla64_1 2015-01-13 13:40:16 2015-01-13 15:17:16 1.616667 hours
2      R_2 2015-01-13 12:50:31 2015-01-13 15:17:15 2.445556 hours
3     sh_3 2015-01-13 13:40:16 2015-01-13 15:17:15 1.616389 hours
```

and these two plots:

[![CPU plot](https://github.com/gregorgorjanc/cpumemlog/raw/master/fig/cpumemlog_1234.txt_cpu_plot.png)](#CPUplot)

[![RAM plot](https://github.com/gregorgorjanc/cpumemlog/raw/master/fig/cpumemlog_1234.txt_mem_plot.png)](#RAMplot)

Both scripts have some useful options, so make sure you check their
documentation in the source Luke!

## TODO (any volunteers?)

* Describe the output from cpumemlog.sh in more detail (I keep forgetting
  what those acronyms mean).

* Compute cumulative usage for the monitored process and all its children.

* ...

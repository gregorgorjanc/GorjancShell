# -*- coding: utf-8 -*-
"""
02/02/2018

Python version of cpumemlogplot.R written by Gregor Gorjanc.
Author: Joanna Ilska

Usage: cpumemlogplot.py cpumemlog_PID.txt <optional arguments>

Optional arguments:
        - g - printing out summary for the processes rather than overall. Default none. 
        - m - reporting in Mb (default Gb)
        - 2 - number of plots (default 1)

WARNING: 
    the plotting function tsplot will be soon removed from seaborn plotting library - the script may stop working
"""
import matplotlib.pyplot as plt
import seaborn as sb
import pandas as pd
import numpy as np
import sys

import warnings
warnings.filterwarnings('ignore')


np.set_printoptions(suppress=True)
np.set_printoptions(precision=5)

try:
    if __name__ == "__main__":
        if len(sys.argv) > 2:
            filename = sys.argv[1]
            args=sys.argv[2:]
        elif len(sys.argv) == 2:
            filename = sys.argv[1]
            args=[]
        else:
            pass        
            
    
    jobID=filename.split('_')[1][:-4]
    
    dat = pd.read_csv(filename, sep=' ', header=0)
    
    # Remove rows where date ="defunct"
    dat = dat[dat.DATE != "defunct"]
    
    # Merge date and time
    dat['X']=pd.to_datetime(dat['DATE'] + ' ' + dat['TIME'])
    
    # binPOwer and binUnit depend on the argument - default Gb
    if 'm' in args:
        binPower=10
        binUnit="Mb"
    else:
        binPower=20
        binUnit="Gb"
    
    # Change the RSS unit based on arguments
    dat['RSS']=dat['RSS']/2**binPower
    
    # Print overall summary statistics to output file, with PID included in the name
    g=open("{}_cpumem_stats.csv".format(jobID), 'w')
    cols=["Obs", "Mean", "Median", "SD", "Min", "Max"]
    
    g.write("Summary statistics for process {}\n".format(jobID))
    
    g.write("RAM {}\n".format(binUnit))
    
    g.write("%s\n" % ','.join(cols))
    g.write("{},{:1.4f},{:1.4f},{:1.4f},{:1.4f},{:1.4f}\n\n".format(dat['RSS'].describe()[0], dat['RSS'].describe()[1], dat['RSS'].describe()[5], dat['RSS'].describe()[2], dat['RSS'].describe()[3], dat['RSS'].describe()[7]))
    
    g.write("CPU\n")
    g.write("%s\n" % ','.join(cols))
    g.write("{},{:1.4f},{:1.4f},{:1.4f},{:1.4f},{:1.4f}\n\n".format(dat['PCPU'].describe()[0], dat['PCPU'].describe()[1], dat['PCPU'].describe()[5], dat['PCPU'].describe()[2], dat['PCPU'].describe()[3], dat['PCPU'].describe()[7]))
    
    g.write("Time\n")
    g.write("{},{},{},{}\n".format("Obs", "Start", "Finish", "total time"))
    st=dat['X'].describe()[4]
    fin=dat['X'].describe()[5]
    tot="{}".format(fin-st)
    g.write("{},{},{},{}\n\n".format(dat['X'].describe()[0], st, fin, tot))
    
    g.close()
    
    # Add the detailed description of each process involved, if required by arguments. Separate files for RAM, CPU and time. 
    if 'g' in args:
        dat.groupby(["COMMAND"])['RSS'].describe()[['count', 'mean', '50%', 'std', 'min', 'max']].to_csv("{}_RAM.csv".format(jobID))
        dat.groupby(["COMMAND"])['PCPU'].describe()[['count', 'mean', '50%', 'std', 'min', 'max']].to_csv("{}_CPU.csv".format(jobID))
        
        tim=dat.groupby(["COMMAND"])['X'].describe()[['count', 'first', 'last']]
        tim['tot']=tim['last']-tim['first']
        tim.to_csv("{}_time.csv".format(jobID))
        
    else:
        pass
    
    
    #################################################################
    # Plotting: 
    
    sb.set()
    
    # Rename the column 
    dat = dat.rename(index=str, columns={"COMMAND":"PROCESS"})
    dat = dat.set_index('DATE')
        
    start=min(dat.X)
    dat['H']=dat['X']-start
    
    dat['H']=dat['H'].astype('timedelta64[s]')/3600
    
    # Depending on arguments, one or two plots
    if '2' in args:
        fig1, ax1 = plt.subplots()
        sb.tsplot(data=dat, time='H', condition="PROCESS", value="RSS", ax=ax1)
        ax1.set_ylabel("RAM ({})".format(binUnit))
        ax1.set_xlabel("Time in hours")
        fig1.tight_layout()
        plt.savefig("{}_RAM.jpg".format(jobID), dpi=199)
        
        fig2, ax2 = plt.subplots()
        sb.tsplot(data=dat, time='H', condition="PROCESS", value="PCPU", ax=ax2)
        ax2.set_ylabel("CPU (%)")
        ax2.set_xlabel("Time in hours")
        fig2.tight_layout()
        plt.savefig("{}_CPU.jpg".format(jobID), dpi=199)   
        
        
    else:
        fig, (ax1, ax2) = plt.subplots(2, sharex=True)
        
        sb.tsplot(data=dat, time='H', condition="PROCESS", value="RSS", ax=ax1)
        sb.tsplot(data=dat, time='H', condition="PROCESS", value="PCPU", ax=ax2)
        
        ax1.set_xlabel('')
        ax2.set_xlabel("Time in hours")
        
        ax1.set_ylabel("RAM ({})".format(binUnit))
        ax2.set_ylabel("CPU (%)")
        
        ax1.legend_.remove()
        
        fig.tight_layout()
        
        plt.savefig("{}_cpumem.jpg".format(jobID), dpi=199)

except NameError:
    print("Required for cpumemlog.py: <cpumemlog_jid.txt> <optional arguments (g, m and 2)>")
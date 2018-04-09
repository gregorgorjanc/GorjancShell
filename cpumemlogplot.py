# -*- coding: utf-8 -*-
"""
04/04/2018

Python version of cpumemlogplot.R written by Gregor Gorjanc.
Author: Joanna Ilska

Usage: cpumemlogplot.py cpumemlog_PID.txt <optional arguments>

Optional arguments:
        - g - printing out summary for the processes rather than overall. Default none. 
        - m - reporting in Mb (default Gb)
        - 2 - number of plots (default 1)

"""
import matplotlib.pyplot as plt
import seaborn as sb
import pandas as pd
import numpy as np
import sys


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
            
    # Extract the job ID from the file name for further labeling
    jobID=filename.split('_')[1][:-4]
    
    # Read the measurements into pandas dataframe
    dat = pd.read_csv(filename, sep=' ', header=0, error_bad_lines=False)
    
    # Remove rows where date ="defunct" - this is an artefact from R script by Gregor. In python/pandas, defunct lines are dealt with by error_bad_lines in parser
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
    
    # Set seaborn plotting colours
    sb.set()
    
    # Set date as index
    dat = dat.set_index('DATE')
        
    # Calculate the start time and times at the measurements
    start=min(dat.X)
    dat['H']=dat['X']-start
    
    dat['H']=dat['H'].astype('timedelta64[s]')/3600
    
    # Split into RSS and CPU frames
    R=dat[['H', 'PID', 'RSS']]
    C=dat[['H', 'PID', 'PCPU']]
    
    # Pivot them, so that each process has a separate column and replace NaNs with 0s. 
    Rpiv=R.pivot(index='H', columns='PID', values='RSS')
    Cpiv=C.pivot(index='H', columns='PID', values='PCPU')
    
    # Extract the labels for the PIDs
    k=dat[['PID', 'COMMAND']].drop_duplicates()
    k=k.set_index('PID')
    dic=k.to_dict()['COMMAND']
    

    # Depending on arguments, one or two plots
    if '2' in args:
        fig1, ax1 = plt.subplots()
        Rpiv.plot(ax=ax1)
        handles, labels = ax1.get_legend_handles_labels()
        new_labels=[dic[int(x)] for x in labels]
        ax1.legend(handles, new_labels)
        ax1.set_ylabel("RAM ({})".format(binUnit))
        ax1.set_xlabel("Time in hours")
        fig1.tight_layout()
        plt.savefig("{}_RAM.jpg".format(jobID), dpi=199)
        #plt.show()
        
        
        fig2, ax2 = plt.subplots()
        Cpiv.plot(ax=ax2)
        handles, labels = ax2.get_legend_handles_labels()
        new_labels=[dic[int(x)] for x in labels]
        ax2.legend(handles, new_labels)
        ax2.set_ylabel("CPU (%)")
        ax2.set_xlabel("Time in hours")
        fig2.tight_layout()
        plt.savefig("{}_CPU.jpg".format(jobID), dpi=199)   
        #plt.show()
        
    else:
        fig, (ax1, ax2) = plt.subplots(2, sharex=True)
        
        Rpiv.plot(ax=ax1)
        Cpiv.plot(ax=ax2)
        
        ax1.set_xlabel('')
        ax2.set_xlabel("Time in hours")
        
        ax1.set_ylabel("RAM ({})".format(binUnit))
        ax2.set_ylabel("CPU (%)")
        
        handles, labels = ax2.get_legend_handles_labels()
        new_labels=[dic[int(x)] for x in labels]
        ax2.legend(handles, new_labels)
        ax1.legend_.remove()
        
        fig.tight_layout()
        
        #plt.show()
        plt.savefig("{}_cpumem.jpg".format(jobID), dpi=199)
        

except NameError:
    print("Required for cpumemlog.py: <cpumemlog_jid.txt> <optional arguments (g, m and 2)>")
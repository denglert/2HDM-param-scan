# 2HDM Parameter space excluded/allowed regions

# Based on:

### 2HDMC - https://2hdmc.hepforge.org

### HiggsBounds - http://higgsbounds.hepforge.org

### HiggsSignals - http://higgsbounds.hepforge.org

Distributed under GNU General Public License: http://www.gnu.org/licenses/


## Manual

### Prerequisites:

You need to have basic packages installed (gnuplot, awk, g++) and also install 2HDMC, HiggsBounds, HiggsSignals. Also you need to create the following static libraries of 2HDMC, HiggsBounds, HiggsSignals which are linked with my program:

lib2HDMC.a
libHB.a
libHS.a

(please refer to the manuals of 2HDMC, HB and HS for installing and creating these static libraries)

Once this is done then you need to set the following PATH variables in the ./src/Makefile:
- LIBDIRLINK
This should point to the directory where the *.a are placed.

- INCDIRLINK
This should point to the directory where 2HDMC/src is installed e.g. /home/david/installed/2HDMC-1.7.0/src/

You may also wish to change the compiler from ifort to gcc/g++ in ./src/Makefile.

If everything is done properly you should be able to compile with just typing 'make' and produce a binary in ./bin directory (./bin/ParameterScan_Hybrid_MultiDim)

### Usage:

1, Check the current settings in the ./Makefile

#### run_segment
run_TASK - selects the .sh script to run in ./tasks/
run_CONFIG - parameter space config found in ./config directory (what range, how many points in each dim, etc)
run_TAG - should be equal to the working directory (default is test)
run_WRITELHA - 1 - write full LHA output as well, 0 - don't write LHA output

#### form_dat segment
These help you to filter and format the output data coming from 2HDMC, HB, HS.

The list of
form_data_parameters = parameter_value
are the parameters and their values you wish to set

form_dat_filterfield
form_dat_filterval
Determines which filter variables and values you use in the end

#### fig_segment

fig_job_tag = the working dir in which the script looks to plot from
fig_out_tag = which subset of results named by the 'tag' to plot

2, Create a new working directory in ./results/test
> make new TAG=test

3, Interactive run:
> make run
(this takes ~1hr on 50x50=2500 pts)

4, Format the data so that gnuplot can process it and determine chi2_min and deltachi2
> make format_data

5, Create figures which are placed in ./results/test/figures/paramspace/
> make fig_param

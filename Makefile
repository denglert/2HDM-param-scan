######################################################
### --- Makefile for 2HDM Parameter space scan --- ###
######################################################

#############################
### -- Interactive run -- ###
#############################

run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
run_TAG      = "test"
run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc.config"
run_WRITELHA = 1

# Extract Makefile variables having 'run_' string; strip the prefix 'run_';
# make <varname>=<varvalue> pairs; pass these variable list to shell
VAR_RUN    = $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/run_/' | sed 's/run_//g' )
EXPORT_RUN = $(foreach v,$(VAR_RUN),$(v)="$(run_$(v))")

#########################
### -- Format data -- ###
#########################

form_dat_job_tag = test
form_dat_out_tag = output_form_dat_mA_$(form_dat_mA)

form_dat_opt   = 2
#form_dat_mA    = 185.428642# Field 13

form_dat_mh    = 125.0# Field 13
form_dat_mH    = 500.0# Field 13
form_dat_mHc   = ${form_dat_mH}# Field 13
form_dat_mA    = 150.0# Field 13
#form_dat_mA    = 400.0 # Field 13
form_dat_cosba =   0.000000# Field 3
form_dat_tanb  =   0.000000# Field 4 
form_dat_Z4    =  -1.000000# Field 5
form_dat_Z5    =   1.000000# Field 6

form_dat_Z7    =  0.000000# Field 7

form_dat_l6    =   0.000000e+00# Field 17
form_dat_l7    =   0.000000e+00# Field 18
form_dat_m12_2 =   1.580000e+04# Field 19

form_dat_XVar = 3
form_dat_YVar = 4

###

form_dat_filterfield1 = 1
form_dat_filterfield2 = 13
form_dat_filterfield3 = 2
form_dat_filterfield4 = 16
form_dat_filterfield5 = 7

form_dat_filterval1 = $(form_dat_mh)
form_dat_filterval2 = $(form_dat_mA)
form_dat_filterval3 = $(form_dat_mH)
form_dat_filterval4 = $(form_dat_mHc)
form_dat_filterval5 = $(form_dat_Z7)

#######

# Extract Makefile variables having 'form_dat' string; make <varname>=<varvalue>
# pairs; pass these variable list to shell

VAR_FORM_DAT    := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/form_dat/')
EXPORT_FORM_DAT := $(foreach v,$(VAR_FORM_DAT),$(v)='$($(v))')

##########################
### -- Make figures -- ###
##########################

fig_job_tag = $(form_dat_job_tag)
fig_out_tag = $(form_dat_out_tag)

###################################################################################

all : build_allbinaries

test :
	@echo "This is VAR_RUN:"
	@echo "$(VAR_JOB)"
	@echo "This is EXPORT_RUN:"
	@echo "$(EXPORT_JOB)"

run : build
	@$(EXPORT_RUN) ./tasks/$(run_TASK); 

new : 
	@TAG=$(TAG); ./scripts/createWD.sh

fig_param : 
	@cd ./results/$(fig_job_tag)/figures/paramspace; ../../../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)
#	cd figures/$(fig_job_tag); gnuplot -e "config=../../results/${fig_job_tag}/${fig_out_tag}_gnu.conf; ../../gnuplot/chisq_distr.gnu

format_data : 
	@cd results/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh; echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config


build : build_allbinaries


build_allbinaries : 
	@ cd src; make binaries;


clean :
	rm -f ./lib/*.o
	find ./bin/ -type f -not -name 'dummy' | xargs rm -f
	rm -f ./src/.depend_cpp
	touch ./src/.depend_cpp


.PHONY: figures

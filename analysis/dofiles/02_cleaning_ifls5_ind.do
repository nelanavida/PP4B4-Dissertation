*================================================================================
*  Reap What You Sow: Education and Long-term Cognitive Ability Impact     
*           		 Nela Navida - MPA LSE 2024
*================================================================================

clear all
capture log close
discard

*storage
*input IFLS5

global input "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/IFLS/IFLS 5/Data/hh14_all_dta"

*process
*cd "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/dofiles/cleaning_IFLS5", clear

*intermediate files* 
global intdata "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/intdata"

*final files* 
global finaldata "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/finaldata"

*output
global output "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/output"

*--------------------------------------------------------
*	 cleaning Individual dataset excp migration (B3A_COV,
* B3A_DL1, BEK_EK2, B3B_COB, B3B_CO1)
*--------------------------------------------------------

** cleaning dataset B3A_COV

use "$input/b3a_cov" , clear 

keep hhid14 hhid14_9 pid14 sex age dob_day dob_mth dob_yr

* store temporarily 
tempfile vars_ind1
save `vars_ind1', replace


** cleaning dataset B3A_DL1

use "$input/b3a_dl1" , clear 

rename dl05a agefirstschool

keep hhid14 hhid14_9 pid14 agefirstschool

* store temporarily 
tempfile vars_ind2
save `vars_ind2', replace


** cleaning dataset B3B_CO1

use "$input/b3b_co1" , clear 

* create outcome variable of cognitive ability: episodic memory *

gen memory_episodic = co07count + co10count

* create outcome variable of cognitive ability: memory intactness *

gen serialseven1 = 0 
replace serialseven1 = 1 if co04a == 93 & co04ax == 1 
replace serialseven1 = . if co04a == .

gen serialseven2 = 0 
replace serialseven2 = 1 if co04a - co04b == 7 & co04bx == 1 
replace serialseven2 = . if co04a == .

gen serialseven3 = 0 
replace serialseven3 = 1 if co04b - co04c == 7 & co04bx == 1 
replace serialseven3 = . if co04a == .

gen serialseven4 = 0 
replace serialseven4 = 1 if co04c - co04d == 7 & co04bx == 1 
replace serialseven4 = . if co04a == .

gen serialseven5 = 0 
replace serialseven5 = 1 if co04d - co04e == 7 & co04bx == 1 
replace serialseven5 = . if co04a == .

gen memory_intactness_serialseven = serialseven1 + serialseven2 + serialseven3 + serialseven4 + serialseven5


recode co02 (1=1) (2=0) (3=0) (5=0) (6=0), gen(daterecall1)

recode co04 (1=1) (3=0) (6=0), gen(daterecall2)

gen memory_intactness_daterecall = daterecall1 + daterecall2

gen memory_intactness = memory_intactness_daterecall + memory_intactness_serialseven


* label *  

label variable memory_episodic "total of delayed recall words and immediate recall"
label variable  memory_intactness_serialseven "total serial sevel questions"
label variable memory_intactness_daterecall "total date recall corret"
label variable memory_intactness "total of the serial seven questions and date recall"


keep hhid14 hhid14_9 pid14 memory_episodic memory_intactness_serialseven memory_intactness_daterecall memory_intactness 

* store temporarily 
tempfile vars_ind3
save `vars_ind3', replace

** cleaning dataset B3B_COB

use "$input/b3b_cob" , clear 

keep hhid14 hhid14_9 pid14  w_abil

* store temporarily 
tempfile vars_ind4
save `vars_ind4', replace

** cleaning dataset EK_EK2

use "$input/ek_ek2" , clear 

* create variable of numerical ability by adding correct answer for the numerical questions *

gen numerical = ek18_ans + ek19_ans + ek20_ans + ek21_ans + ek22_ans

* create variable of fluid intelligence by adding correct answer for the Raven's test *

gen fluidint = ek1_ans + ek2_ans + ek3_ans + ek4_ans + ek5_ans + ek6_ans + ek11_ans + ek12_ans

* label *  

label variable numerical  "numerical ability based on the numeracy test"
label variable  fluidint "fluid intelligence based on Raven's test questions"

keep hhid14 hhid14_9 pid14 numerical fluidint

* store temporarily 
tempfile vars_ind5
save `vars_ind5', replace

*--------------------------------------------------------
*				merging data
*--------------------------------------------------------

* I will merge data from B3A_COV B3A_DL1, BEK_EK2, B3B_COB, B3B_CO1 

use `vars_ind1', clear
merge m:1 hhid14 pid using `vars_ind2'
drop _m

merge m:1 hhid14 pid using `vars_ind3'
drop _m

merge m:1 hhid14 pid using `vars_ind4'
drop _m

merge m:1 hhid14 pid using `vars_ind5'
drop _m

save "$intdata/ind_dataset.dta", replace


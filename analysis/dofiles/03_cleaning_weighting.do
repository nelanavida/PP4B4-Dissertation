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
*				Weighting dataset
*--------------------------------------------------------

use "$input/ptrack.dta", clear
keep ar01a_14 hhid14 pid14 pidlink pwt14xa
order hhid14 pid14 pidlink pwt14xa ar01a_14 

save "$intdata/status_weight.dta", replace


use "$intdata/status_weight.dta", clear

merge m:1 hhid14 pid14 pidlink using "$intdata/hh_dataset.dta"

drop _merge

merge m:1 hhid14 pid14 using "$intdata/ind_dataset.dta"

keep if _merge == 3

drop _merge

save "$intdata/indhhweight_dataset.dta", replace

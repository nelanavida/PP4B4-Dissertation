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
*	clean data school construction
*--------------------------------------------------------

use "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/esther_data.dta", clear

gen regency12_esther95 = prop*100 + kab

gen number_children = totin/nin

reg totin number_children

predict resid, residuals

gen totin_74 = inp73s + inp74s
gen school_intensity_74 = totin_74 / ch71 * 1000

gen high_intensity = 0 
replace high_intensity = 1 if resid > 0
replace high_intensity = . if resid ==.


rename nin school_intensity 

keep regency12_esther95 school_intensity school_intensity_74 high_intensity totin number_children area pop71 tea7374u tea7879u wsppc fiscpc en71 ch71 inp73s inp74s totin_74 ch73e

duplicates drop regency12_esther95, force

save "$intdata/cleaned_schoolconst.dta", replace


*--------------------------------------------------------
*	merge the main IFLS with school construction
*--------------------------------------------------------

use "$intdata/cleaned_ifls5", clear

merge m:1 regency12_esther95 using "$intdata/cleaned_schoolconst.dta"

keep if _merge == 3

drop _merge

save "$finaldata/ifls5_school construction.dta", replace






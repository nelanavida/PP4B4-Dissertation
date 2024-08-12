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
*	merging individual and HH dataset and location at 12
*--------------------------------------------------------

use "$intdata/indhhweight_dataset.dta", clear
duplicates drop pidlink, force
merge 1:1 pidlink using "$intdata/migration_all_codealigned", keepusing(pidlink regency12_bps14 regency12_bps07 regency12_bps00 regency12_bps98 regency12_esther95 regency_birth_bps14 regency_birth_bps07 regency_birth_bps00 regency_birth_bps98 regency_birth_esther95  )
drop if _merge == 1
drop _merge

duplicates drop pidlink, force 
merge 1:1 pidlink using  "$intdata/parents_education_ifls.dta", keepusing(mother_educyr father_educyr educ_mother educ_father)
drop if _merge == 2
drop _merge 

save "$intdata/pre_cleaned_ifls5", replace

*--------------------------------------------------------
*	merging parents education
*--------------------------------------------------------

use "$intdata/pre_cleaned_ifls5", clear

duplicates drop pidlink, force 
merge 1:1 pidlink using  "$intdata/parents_education_ifls.dta", keepusing(mother_educyr father_educyr educ_mother educ_father)
drop if _merge == 2
drop _merge 
save "$intdata/cleaned_ifls5", replace


*merge parents status in 07 00 97 and 93

merge 1:1 pidlink using "$intdata/education_parents_ifls5", keepusing(mother_educyr father_educyr)
drop if _merge == 2
drop _merge

merge 1:1 pidlink using "$intdata/education_parents_ifls4", keepusing(mother_educyr_07 father_educyr_07)
drop if _merge == 2
drop _merge

merge 1:1 pidlink using "$intdata/education_parents_ifls3", keepusing(mother_educyr_00 father_educyr_00)
drop if _merge == 2
drop _merge

merge 1:1 pidlink using "$intdata/education_parents_ifls2", keepusing(mother_educyr_97 father_educyr_97)
drop if _merge == 2
drop _merge

merge 1:1 pidlink using "$intdata/education_parents_ifls1", keepusing(mother_educyr_93 father_educyr_93)
drop if _merge == 2
drop _merge

gen educ_mother = .
replace educ_mother = mother_educyr if mother_educyr != .
replace educ_mother = mother_educyr_07 if mother_educyr == .
replace educ_mother = mother_educyr_00 if mother_educyr == .
replace educ_mother = mother_educyr_97 if mother_educyr == .
replace educ_mother = mother_educyr_93 if mother_educyr == .

gen educ_father = .
replace educ_father = father_educyr if mother_educyr != .
replace educ_father = father_educyr_07 if father_educyr == .
replace educ_father = father_educyr_00 if father_educyr == .
replace educ_father = father_educyr_97 if father_educyr == .
replace educ_father = father_educyr_93 if father_educyr == .



replace mother_educyr = mother_educyr_07 if mother_educyr == .
replace mother_educyr = mother_educyr_00 if mother_educyr == . | mother_educyr_07 == . 
replace mother_educyr = mother_educyr_97 if mother_educyr == . | mother_educyr_07 == . | mother_educyr_00 == .
replace mother_educyr = mother_educyr_93 if mother_educyr == . | mother_educyr_07 == . | mother_educyr_00 == . | mother_educyr_97 == . 

replace father_educyr = father_educyr_07 if father_educyr == .
replace father_educyr = father_educyr_00 if father_educyr == . | father_educyr_07 == . 
replace father_educyr = father_educyr_97 if father_educyr == . | father_educyr_07 == . | father_educyr_00 == .
replace father_educyr = father_educyr_93 if father_educyr == . | father_educyr_07 == . | father_educyr_00 == . | father_educyr_97 == . 

drop mother_educyr_07 father_educyr_07 mother_educyr_00 father_educyr_00 mother_educyr_97 father_educyr_97 mother_educyr_93 father_educyr_93


save "$intdata/cleaned_ifls5", replace

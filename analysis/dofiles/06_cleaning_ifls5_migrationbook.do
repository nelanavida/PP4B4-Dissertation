*================================================================================
*  Reap What You Sow: Education and Long-term Cognitive Ability Impact     
*           		 Nela Navida - MPA LSE 2024
*================================================================================

clear all
capture log close
discard

*storage

* input IFLS all 
global IFLS "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/IFLS"


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
*	 cleaning Individual dataset: migration 
*--------------------------------------------------------
* Information gathered: where they live when 12 y.o. 
** IFLS 5 **

use "$input/b3a_mg1" , clear

gen province_12_14 = . 
replace province_12_14 = mg01d if mg04a == 1
replace province_12_14 = mg05d if mg04a == 3 | mg04a == 8
replace province_12_14 = mg03ad if mg03adx == 1 | mg03adx == 3
replace province_12_14 = mg07d if mg07dx == 1


gen regency_12_14 = . 
replace regency_12_14 = mg01c if mg04a == 1
replace regency_12_14 = mg05c if mg04a == 3 | mg04a == 8
replace regency_12_14 = mg03ac if mg03acx == 1 | mg03acx == 3 & mg04a == 1
replace regency_12_14 = mg07c if mg07cx == 1

// make the regency code into 4 digits based on 2014 code

gen regency12_14_bps14 = province_12_14*100 + regency_12_14

keep hhid14_9 pid14 hhid14 pidlink province_12_14 regency_12_14 regency12_14_bps14 

merge m:m regency12_14_bps14 using "$intdata/concordance_IFLS5"
drop if _merge == 2
drop _merge

save "$intdata/migration_2014", replace


** IFLS 4 ** 

use "$IFLS/IFLS 4/Data/hh07_all_dta/b3a_mg1.dta", clear

gen province_12_07 = . 
replace province_12_07 = mg01d if mg04a == 1 
replace province_12_07 = mg05d if mg04a == 3 
replace province_12_07 = mg03ad if mg03adx == 1 | mg03adx == 3
replace province_12_07 = mg07d if mg07dx == 1

gen regency_12_07 = . 
replace regency_12_07 = mg01c if mg04a == 1
replace regency_12_07 = mg05c if mg04a == 3 | mg04a == 8
replace regency_12_07 = mg03ac if mg03acx == 1 | mg03acx == 3 & mg04a == 1
replace regency_12_07 = mg07c if mg07cx == 1

// make the regency code into 4 digits based on 2014 code
gen regency12_07_bps07 = province_12_07*100 + regency_12_07

keep  pidlink hhid07 pid07 province_12_07 regency_12_07 regency12_07_bps07

merge m:m regency12_07_bps07 using "$intdata/concordance_IFLS4"
drop if _merge == 2
drop _merge

save "$intdata/migration_2007", replace

** IFLS 3 ** 

use "$IFLS/IFLS 3/hh00_all_dta/b3a_mg1.dta", clear

gen province_12_00 = . 
replace province_12_00 = mg01d if mg04a == 1 
replace province_12_00 = mg05d if mg04a == 3 
replace province_12_00 = mg03ad if mg03adx == 1 | mg03adx == 3
replace province_12_00 = mg07d if mg07dx == 1

gen regency_12_00 = . 
replace regency_12_00 = mg01c if mg04a == 1
replace regency_12_00 = mg05c if mg04a == 3 | mg04a == 8
replace regency_12_00 = mg03ac if mg03acx == 1 | mg03acx == 3 & mg04a == 1
replace regency_12_00 = mg07c if mg07cx == 1

// make the regency code into 4 digits based on 2014 code
gen regency12_00_bps00 = province_12_00*100 + regency_12_00

keep  pidlink hhid00 pid00 province_12_00 regency_12_00 regency12_00_bps00

merge m:m regency12_00_bps00 using "$intdata/concordance_IFLS3"
drop _merge

save "$intdata/migration_2000", replace

** IFLS 2 **

use "$IFLS/IFLS 2/Data/hh97dta/b3a_mg1.dta", clear

gen province_12_97 = . 
replace province_12_97 = mg01d if mg04a == 1 
replace province_12_97 = mg05d if mg04a == 3 
replace province_12_97 = mg03d if mg03dx == 1 | mg03dx == 3
replace province_12_97 = mg07d if mg07dx == 1

gen regency_12_97 = . 
replace regency_12_97 = mg01c if mg04a == 1
replace regency_12_97 = mg05c if mg04a == 3 | mg04a == 8
replace regency_12_97 = mg03c if mg03cx == 1 | mg03cx == 3 & mg04a == 1
replace regency_12_97 = mg07c if mg07cx == 1

// make the regency code into 4 digits based on 2014 code
gen regency12_97_bps98 = province_12_97*100 + regency_12_97

keep  pidlink hhid97 pid97 province_12_97 regency_12_97 regency12_97_bps98

merge m:m regency12_97_bps98 using "$intdata/concordance_IFLS2"

save "$intdata/migration_1997", replace

** IFLS 1 **  

use "$IFLS/IFLS 1/Data/hh93dta/buk3mg1.dta", clear

gen province_12_93 = . 
replace province_12_93 = mg05d2


gen regency_12_93 = . 
replace regency_12_93 = mg05c2

// make the regency code into 4 digits based on 2014 code
gen regency12_93_bps93 = province_12_93*100 + regency_12_93


keep  pidlink hhid93 pid93 province_12_93 regency_12_93 regency12_93_bps93

save "$intdata/migration_1993", replace


*--------------------------------------------------------
*				merging data
*--------------------------------------------------------

use "$intdata/migration_2014", clear
duplicates drop pidlink, force

merge 1:m pidlink using "$intdata/migration_2007"
drop if _merge == 2
drop _merge

duplicates drop pidlink, force
merge m:m pidlink using "$intdata/migration_2000"
drop if _merge == 2
drop _merge

duplicates drop pidlink, force
merge m:m pidlink using "$intdata/migration_1997", gen(m97)
drop if m97 == 2
drop _merge m97 

merge m:1 pidlink using "$intdata/migration_1993"
drop if _merge == 2
drop _merge

save "$intdata/migration_all", replace


*--------------------------------------------------------
*				aligning the regency code
*--------------------------------------------------------

use "$intdata/migration_all", clear

gen regency12_bps14 = . 
replace regency12_bps14 = regency12_14_bps14 
replace regency12_bps14 = regency12_07_bps14 if regency12_bps14 == . 
replace regency12_bps14 = regency12_00_bps14 if regency12_bps14 == .
replace regency12_bps14 = regency12_97_bps14 if regency12_bps14 == .

gen regency12_bps07 = . 
replace regency12_bps07 = regency12_07_bps07 
replace regency12_bps07 = regency12_14_bps07 if regency12_bps07 == . 
replace regency12_bps07 = regency12_00_bps07 if regency12_bps07 == .
replace regency12_bps07 = regency12_97_bps07 if regency12_bps07 == .

gen regency12_bps00 = . 
replace regency12_bps00 = regency12_00_bps00 
replace regency12_bps00 = regency12_14_bps00 if regency12_bps00 == . 
replace regency12_bps00 = regency12_07_bps00 if regency12_bps00 == .
replace regency12_bps00 = regency12_97_bps00 if regency12_bps00 == .

gen regency12_bps98 = . 
replace regency12_bps98 = regency12_97_bps98 
replace regency12_bps98 = regency12_14_bps98 if regency12_bps98 == . 
replace regency12_bps98 = regency12_07_bps98 if regency12_bps98 == .
replace regency12_bps98 = regency12_00_bps98 if regency12_bps98 == .


merge m:m regency12_bps14 using "$intdata/regency_esther95
drop if _merge == 2
drop _merge

replace regency12_esther95 = regency12_93_bps93 if regency12_esther95 == .
replace regency12_esther95 = regency12_bps98 if regency12_esther95 == . 
replace regency12_esther95 = regency12_bps00 if regency12_esther95 == .    
replace regency12_esther95 = regency12_bps07 if regency12_esther95 == .  


save "$intdata/migration_all_codealigned", replace




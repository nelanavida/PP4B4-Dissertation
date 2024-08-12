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
*	 regency code using supas code 
*--------------------------------------------------------

use "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/concordance_bps_ipums_supas95", clear

gen regency12_esther95 = rgcy_esther95
gen regency12_bps14 = rgcy_id2014_1
gen regency_birth_esther95 = rgcy_esther95
gen regency_birth_bps14 = rgcy_id2014_1

keep regency12_bps14 regency12_esther95 regency_birth_esther95 regency_birth_bps14

duplicates drop regency12_bps14, force


save "$intdata/regency_esther95", replace

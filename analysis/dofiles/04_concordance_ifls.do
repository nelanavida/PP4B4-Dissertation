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
*	 make concordance table 
*--------------------------------------------------------

use "$IFLS/IFLS 5/IFLS5_BPS_2014_codes/kec_9899000714.dta", clear

drop kecid98 kecid99 kecid00 kecid07 kecid14
drop nmkec1998 nmkec1999 nmkec2000 nmkec2007 nmkec2014

duplicates drop
drop if kabid14 == .
drop if kabid07 == .
drop if kabid00 ==.
drop if kabid99 == .
drop if kabid98 == .
gsort kabid14

keep kabid98 kabid99 kabid00 kabid07 kabid14 nmkab1998 nmkab1999 nmkab2000 nmkab2007 nmkab2014
 
save "$intdata/concordance_98_14", replace

*--------------------------------------------------------
*	adjust geocode for IFLS 2
*--------------------------------------------------------
use "$intdata/concordance_98_14", clear

gen regency12_97_bps98 = kabid98
gen regency12_97_bps00 = kabid00
gen regency12_97_bps07 = kabid07
gen regency12_97_bps14 = kabid14

gen regency_birth_97_bps98 = kabid98
gen regency_birth_97_bps00 = kabid00
gen regency_birth_97_bps07 = kabid07
gen regency_birth_97_bps14 = kabid14

drop kabid98 kabid99 kabid00 kabid07 kabid14

duplicates drop regency12_97_bps98, force

save "$intdata/concordance_IFLS2", replace

*--------------------------------------------------------
*	adjust geocode for IFLS 3
*--------------------------------------------------------
use "$intdata/concordance_98_14", clear

gen regency12_00_bps98 = kabid98
gen regency12_00_bps00 = kabid00
gen regency12_00_bps07 = kabid07
gen regency12_00_bps14 = kabid14

gen regency_birth_00_bps98 = kabid98
gen regency_birth_00_bps00 = kabid00
gen regency_birth_00_bps07 = kabid07
gen regency_birth_00_bps14 = kabid14

drop kabid98 kabid99 kabid00 kabid07 kabid14

duplicates drop regency12_00_bps00,force

save "$intdata/concordance_IFLS3", replace


*--------------------------------------------------------
*	adjust geocode for IFLS 4
*--------------------------------------------------------
use "$intdata/concordance_98_14", clear

gen regency12_07_bps98 = kabid98
gen regency12_07_bps00 = kabid00
gen regency12_07_bps07 = kabid07
gen regency12_07_bps14 = kabid14

gen regency_birth_07_bps98 = kabid98
gen regency_birth_07_bps00 = kabid00
gen regency_birth_07_bps07 = kabid07
gen regency_birth_07_bps14 = kabid14

drop kabid98 kabid99 kabid00 kabid07 kabid14

duplicates drop regency12_07_bps07, force

save "$intdata/concordance_IFLS4", replace

*--------------------------------------------------------
*	adjust geocode for IFLS 5
*--------------------------------------------------------
use "$intdata/concordance_98_14", clear

gen regency12_14_bps98 = kabid98
gen regency12_14_bps00 = kabid00
gen regency12_14_bps07 = kabid07
gen regency12_14_bps14 = kabid14

gen regency_birth_14_bps98 = kabid98
gen regency_birth_14_bps00 = kabid00
gen regency_birth_14_bps07 = kabid07
gen regency_birth_14_bps14 = kabid14

drop kabid98 kabid99 kabid00 kabid07 kabid14

duplicates drop regency12_14_bps14, force

save "$intdata/concordance_IFLS5", replace





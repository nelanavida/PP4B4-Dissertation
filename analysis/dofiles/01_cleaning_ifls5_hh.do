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

global finaldata "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/finaldata"

*output
global output "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/output"

*--------------------------------------------------------
*		 cleaning HH dataset (BK_AR1 and BK_SC1)
*--------------------------------------------------------

* clean dataset from BK_AR1 

use "$input/bk_ar1" , clear 

** Create variables years of education - educyr **

sort hhid14_9 pid14

*level= pendidikan tertinggi, grade= kelas tertinggi
gen level=ar16 if ar16~=. 
gen grade=ar17 if ar17~=. 
	
* no schooling, kindergarten * 
generate educyr= 0 if level==1 | level==90 | level==98 | level==95 

* elementary school, kejar paket A,  pesantren, madrasah tsanawiyah * 
replace educyr=grade if (level==2 | level==11 | level==14 | level==72) & grade<7  /* masih SD */ 
replace educyr=6 if (level==2 | level==11 | level==14 | level==72) & grade==7  /* graduated from SD*/ 
replace educyr=5 if (level==2 | level==11 | level==14 | level==72) & grade>7   /* not graduated */ 

* junior high general + vocational, kejar paket B,  ibtidaiyah * 
replace educyr=6+grade if (level==3 | level==4 | level==12 | level==17 | level==73) & grade<4 /* masih SMP */ 
replace educyr=9 if (level==3 | level==4 | level==12 | level==17 | level==73) & (grade==4 | grade==5 | grade==7) /* graduated from SMP */ 
replace educyr=8 if (level==3 | level==4 | level==12 | level==17 | level==73) & grade>7 /* not graduated */ 

* senior high general + vocational, kejar paket B,  aaliyah *
replace educyr=9+grade if (level==5 | level==6 | level==15 | level==74) & grade<4 /* masih SMA */ 
replace educyr=12 if (level==5 | level==6 | level==15 | level==74) & (grade==4 | grade==7) /* graduated */ 
replace educyr=11 if (level==5 | level==6 | level==15 | level==74) & grade==98 /* not graduated */ 

* tertiary educ * 
replace educyr=12+grade if (level==13 | level==60 | level==61 | level==62 | level==63) & grade<5 
replace educyr=16 if (level==13 | level==60 | level==61 | level==62 | level==63) & (grade==5 | grade==6 | grade==7)
replace educyr=15 if (level==13 | level==60 | level==61 | level==62 | level==63) & grade>7 

replace educyr=16+grade if (level==62) & grade<3 
replace educyr=18 if (level==62) & (grade==3 | grade==4 | grade==5 | grade==7)
replace educyr=17 if (level==62) & (grade>7) 

replace educyr=18+grade if (level==63) & grade<3 
replace educyr=20 if (level==63) & (grade==3 | grade==4 | grade==5 | grade==7)
replace educyr=19 if (level==63) & (grade>7) 

* College, D1, D2, D3 educ * 
replace educyr=12+grade if (level==60) & grade<=3  /* belum lulus kuliah college*/ 
replace educyr=15 if (level==60) & grade>3 & grade<7  /* belum lulus kuliah college*/ 

* Univ (bachelor) educ * 
replace educyr=12+grade if (level==13 | level==61) & grade<=5  /* belum lulus kuliah college*/ 
replace educyr=17 if (level==13 | level==61) & grade>5 & grade<=7  /* belum lulus kuliah college*/ 

* Univ (master) educ * 
replace educyr=17+grade if (level==13 | level==62) & grade<=2  /* belum lulus kuliah college*/ 
replace educyr=19 if (level==13 | level==62) & grade>2 & grade<=7  /* belum lulus kuliah college*/ 

* Univ (doctorate) educ * 
replace educyr=19+grade if (level==13 | level==61) & grade<=3  /* belum lulus kuliah college*/ 
replace educyr=22 if (level==13 | level==61) & grade>3 & grade<=7  /* belum lulus kuliah college*/ 


* Label the variables u*
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 


** Recode sex **

recode ar07 (1=1) (3=0) , gen(sex_hh)


** Rename variable **
rename ar08day birth_day
rename ar08mth birth_month
rename ar08yr birth_year
rename ar09 age_HH
rename ar15 religion
rename ar15b income
rename ar15c employment 
rename ar15d ethnic

** Keep the variables**

keep hhid14_9 hhid14 pid14 pidlink level grade educyr sex birth_day birth_month birth_year age religion income employment ethnic ar10 ar11

* store temporarily 
tempfile vars_hh1
save `vars_hh1', replace


* clean dataset from BK_SC1

use "$input/bk_sc1" , clear 

* rename the variable * 

rename sc01_14_14 regency
rename sc02_14_14 province

* keep the variables *

keep hhid14_9 hhid14 regency province

* store temporarily 
tempfile vars_hh2
save `vars_hh2', replace

*--------------------------------------------------------
*				merging data
*--------------------------------------------------------
* I will merge data from BK_AR1 and BK_SC1

use `vars_hh1' , clear 
merge m:1 hhid14_9 hhid14 using `vars_hh2'
drop _m

save "$intdata/hh_dataset.dta", replace

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

use "$input/bk_ar1" , clear 
 
* mother and father education * 

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


* Label the variables *
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 

keep hhid14_9 hhid14 pid14 pidlink educyr
rename pid14 ar10
rename educyr father_educyr

gen mother_educyr = father_educyr
gen ar11 = ar10

duplicates drop pidlink, force

save "$intdata/parents_educ_IFLS5.dta", replace


** parents status 

use "$input/bk_ar1" , clear 

keep pidlink hhid14 ar10 ar11

duplicates drop pidlink, force

save "$intdata/parent_status_14", replace



** IFLS 4 **
use "$IFLS/IFLS 4/Data/hh07_all_dta/bk_ar1" , clear 


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


* Label the variables *
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 

keep hhid07_9 hhid07 pid07 pidlink educyr
rename pid07 ar10_07
rename educyr father_educyr_07

gen mother_educyr_07 = father_educyr_07
gen ar11_07 = ar10

duplicates drop pidlink, force

save "$intdata/parents_educ_IFLS4.dta", replace


** make document about ar10_07 and ar11_07

use "$IFLS/IFLS 4/Data/hh07_all_dta/bk_ar1" , clear 

keep hhid07 pidlink ar10 ar11

rename ar10 ar10_07
rename ar11 ar11_07

duplicates drop pidlink, force

save "$intdata/parent_status_07", replace


** IFLS 3

use "$IFLS/IFLS 3/hh00_all_dta/bk_ar1" , clear 


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


* Label the variables *
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 

keep hhid00 pid00 pidlink educyr
rename pid00 ar10_00
rename educyr father_educyr_00

gen mother_educyr_00 = father_educyr_00
gen ar11_00 = ar10_00

duplicates drop pidlink, force

save "$intdata/parents_educ_IFLS3.dta", replace

** parents status 
use "$IFLS/IFLS 3/hh00_all_dta/bk_ar1" , clear 

keep hhid00 pidlink ar10 ar11

rename ar10 ar10_00
rename ar11 ar11_00

duplicates drop pidlink, force

save "$intdata/parent_status_00", replace


** IFLS 2


use "$IFLS/IFLS 2/Data/hh97dta/hh97bk/bk_ar1" , clear 


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


* Label the variables *
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 

keep hhid97 pid97 pidlink educyr
rename pid97 ar10_97
rename educyr father_educyr_97

gen mother_educyr_97 = father_educyr_97
gen ar11_97 = ar10_97

duplicates drop pidlink, force

save "$intdata/parents_educ_IFLS2.dta", replace

** parents status 

use "$IFLS/IFLS 2/Data/hh97dta/hh97bk/bk_ar1" , clear 

keep hhid97 pidlink ar10 ar11

rename ar10 ar10_97
rename ar11 ar11_97

duplicates drop pidlink, force

save "$intdata/parent_status_97", replace


** IFLS 1


use "$IFLS/IFLS 1/Data/hh93dta/bukkar2.dta" , clear 


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


* Label the variables *
label variable level "tingkat pendidikan terakhir" 
label variable grade "kelas pendidikan terakhir" 
label variable educyr "education year atau lama tahun bersekolah" 

keep hhid93 pid93 pidlink educyr
rename pid93 ar10_93
rename educyr father_educyr_93

gen mother_educyr_93 = father_educyr_93
gen ar11_93 = ar10_93

duplicates drop pidlink, force

save "$intdata/parents_educ_IFLS1.dta", replace

** parents status 

use "$IFLS/IFLS 1/Data/hh93dta/bukkar2.dta"  , clear 

keep hhid93 pidlink ar10 ar11

rename ar10 ar10_93
rename ar11 ar11_93

duplicates drop pidlink, force

save "$intdata/parent_status_93", replace


** merge

use "$intdata/parent_status_14", clear
merge m:1 hhid14 ar10 using "$intdata/parents_educ_IFLS5.dta", keepusing (father_educyr)
drop if _merge==2
drop _merge
merge m:1 hhid14 ar11 using "$intdata/parents_educ_IFLS5.dta", keepusing (mother_educyr)
drop if _merge==2
drop _merge

save "$intdata/education_parents_ifls5", replace


use "$intdata/parent_status_07", clear

merge m:1 hhid07 ar10_07 using "$intdata/parents_educ_IFLS4.dta", keepusing(father_educyr)
drop if _merge==2
drop _merge
merge m:1 hhid07 ar11_07 using "$intdata/parents_educ_IFLS4.dta", keepusing(mother_educyr)
drop if _merge==2
drop _merge

save "$intdata/education_parents_ifls4", replace



use "$intdata/parent_status_00", clear

merge m:1 hhid00 ar10_00 using "$intdata/parents_educ_IFLS3.dta", keepusing(father_educyr)
drop if _merge==2
drop _merge
merge m:1 hhid00 ar11_00 using "$intdata/parents_educ_IFLS3.dta", keepusing(mother_educyr)
drop if _merge==2
drop _merge

save "$intdata/education_parents_ifls3", replace


use "$intdata/parent_status_97", clear

merge m:1 hhid97 ar10_97 using "$intdata/parents_educ_IFLS2.dta", keepusing(father_educyr)
drop if _merge==2
drop _merge
merge m:1 hhid97 ar11_97 using "$intdata/parents_educ_IFLS2.dta", keepusing(mother_educyr)
drop if _merge==2
drop _merge

save "$intdata/education_parents_ifls2", replace


use "$intdata/parent_status_93", clear

merge m:1 hhid93 ar10_93 using "$intdata/parents_educ_IFLS1.dta", keepusing(father_educyr)
drop if _merge==2
drop _merge
merge m:1 hhid93 ar11_93 using "$intdata/parents_educ_IFLS1.dta", keepusing(mother_educyr)
drop if _merge==2
drop _merge

save "$intdata/education_parents_ifls1", replace


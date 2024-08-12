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
*				Descriptive Statistics
*--------------------------------------------------------

dtable educyr w_abil fluidint numerical memory_intactness, by(exposed_cohort) note(Source: IFLS, Ministry of Education and Culture) export("descriptive_stats", as(docx) replace)


*--------------------------------------------------------
*					Analysis
*--------------------------------------------------------
* Restricted sample * 
** trial **
// those born in 1957-1971
use "$finaldata/ifls5_school construction.dta", clear

keep if birth_year < 1973
drop if birth_year > 1962 & birth_year < 1968
drop if birth_year < 1958

gen exposed_cohort = 0 
replace exposed_cohort = 1 if birth_year > 1962 

gen instrument_inpres = high_intensity*exposed_cohort

gen intensity_cohort = school_intensity * exposed_cohort

gen sanitation_cohort = wsppc * exposed_cohort

gen java = 0 
replace java = 1 if regency12_esther95 > 3000 & regency12_esther95 < 4000

gen primary_school = 0
replace primary_school = 1 if level > 1 & grade == 7

gen female = 0
replace female = 1 if sex == 3

// create dummy year of birth 
gen d_1972 = 0 
replace d_1972 = 1 if dob_yr == 1972
gen d_1971 = 0
replace d_1971 = 1 if dob_yr == 1971
gen d_1970 = 0
replace d_1970 = 1 if dob_yr == 1970
gen d_1969 = 0
replace d_1969 = 1 if dob_yr == 1969
gen d_1968 = 0
replace d_1968 = 1 if dob_yr == 1968
gen d_1962 = 0
replace d_1962 = 1 if dob_yr == 1962
gen d_1961 = 0
replace d_1961 = 1 if dob_yr == 1961
gen d_1960 = 0
replace d_1960 = 1 if dob_yr == 1960
gen d_1959 = 0
replace d_1959 = 1 if dob_yr == 1959
gen d_1958 = 0
replace d_1958 = 1 if dob_yr == 1958

gen d_1972_en71 = d_1972 * en71
gen d_1971_en71 = d_1971 * en71
gen d_1970_en71 = d_1970 * en71
gen d_1969_en71 = d_1969 * en71
gen d_1968_en71 = d_1968 * en71
gen d_1962_en71 = d_1962 * en71
gen d_1961_en71 = d_1961 * en71
gen d_1960_en71 = d_1960 * en71
gen d_1959_en71 = d_1959 * en71
gen d_1958_en71 = d_1958 * en71

gen d_1972_ch71 = d_1972 * ch71
gen d_1971_ch71 = d_1971 * ch71
gen d_1970_ch71 = d_1970 * ch71
gen d_1969_ch71 = d_1969 * ch71
gen d_1968_ch71 = d_1968 * ch71
gen d_1962_ch71 = d_1962 * ch71
gen d_1961_ch71 = d_1961 * ch71
gen d_1960_ch71 = d_1960 * ch71
gen d_1959_ch71 = d_1959 * ch71
gen d_1958_ch71 = d_1958 * ch71


gen d_1972_saniation = d_1972 * wsppc
gen d_1971_saniation = d_1971 * wsppc
gen d_1970_sanitation = d_1970 * wsppc
gen d_1969_sanitation = d_1969 * wsppc
gen d_1968_sanitation = d_1968 * wsppc
gen d_1962_sanitation = d_1962 * wsppc
gen d_1961_sanitation = d_1961 * wsppc
gen d_1960_sanitation = d_1960 * wsppc
gen d_1959_sanitation = d_1959 * wsppc
gen d_1958_sanitation = d_1958 * wsppc

gen prop_child_1971 = ch71/pop71
gen d_1972_propch71 = d_1972 * prop_child_1971
gen d_1971_propch71 = d_1971 * prop_child_1971
gen d_1970_propch71 = d_1970 * prop_child_1971
gen d_1969_propch71 = d_1969 * prop_child_1971
gen d_1968_propch71 = d_1968 * prop_child_1971
gen d_1962_propch71 = d_1962 * prop_child_1971
gen d_1961_propch71 = d_1961 * prop_child_1971
gen d_1960_propch71 = d_1960 * prop_child_1971
gen d_1959_propch71 = d_1959 * prop_child_1971
gen d_1958_propch71 = d_1958 * prop_child_1971

gen religion_majority = 0
replace religion_majority = 1 if religion == 1
tab ethnic
gen ethnic_majority = 0
replace ethnic_majority = 1 if ethnic == 1


gen dob_m_yr = dob_mth * dob_yr

gen cohort_en71 = exposed_cohort * en71

gen cohort_ch71 = exposed_cohort * prop_child_1971


gen firstschool_year = agefirstschool + dob_yr

gen feeabolition = 0
replace feeabolition = 1 if firstschool_year > 1977

gen academic_shift = 0 
replace academic_shift = 1 if firstschool_year < 1978

duplicates drop pidlink, force

drop if regency_birth_esther95 > 9000

gen agesq = age*age

*--------------------------------------------------------
*				Descriptive Statistics
*--------------------------------------------------------

dtable educyr w_abil fluidint numerical memory_intactness, by(exposed_cohort) note(Source: IFLS, Ministry of Education and Culture) export("descriptive_stats", as(docx) replace)


*--------------------------------------------------------
*				Regression
*--------------------------------------------------------


* Naive OLS 

reg fluidint educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols1, title(Fluid Intelligence Raven's Test)

reg w_abil educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols2, title(Fluid Intelligence W-Score)

reg numerical educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust 
estimates store ols3, title(Numerical Ability)

reg memory_intactness educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols4, title(Memory Intactness)

esttab ols1 ols2 ols3 ols4 using "$output/OLS_restricted.rtf, keep(educyr age agesq female _cons) se(%7.2f) b(%7.2f) ar2 


* first stage intensity cohort * 

// with Duflo control 
reg educyr intensity_cohort 

reg educyr intensity_cohort sanitation_cohort

* second stage using instrument of intesity cohort *

ivregress 2sls w_abil age gender (educyr = intensity_cohort)
ivregress 2sls w_abil age gender (educyr = intensity_cohort) if java == 1
ivregress 2sls w_abil age gender (educyr = intensity_cohort) if java == 0
ivregress 2sls fluidint age gender (educyr = intensity_cohort) if java == 0
ivregress 2sls fluidint age gender (educyr = intensity_cohort) if java == 1
ivregress 2sls numerical age gender (educyr = intensity_cohort) if java == 1
ivregress 2sls memory_intactness age gender (educyr = intensity_cohort) if java == 1
ivregress 2sls memory_intactness age gender (educyr = intensity_cohort) if java == 0
ivregress 2sls memory_intactness age gender (educyr = instrument_inpres) if java == 0
ivregress 2sls memory_intactness age gender (educyr = instrument_inpres) if java == 1
ivregress 2sls fluidint age gender (educyr = instrument_inpres) if java == 1
ivregress 2sls numerical age gender (educyr = instrument_inpres) if java == 1
ivregress 2sls w_abil age gender (educyr = instrument_inpres) if java == 1
ivregress 2sls w_abil age gender (educyr = intensity_cohort) if java == 1
reg educyr intensity_cohort
reg educyr instrument_inpres
reg educyr instrument_inpres
reg educyr intensity_cohort

* with control variable

ivregress 2sls w_abil i.dob_m_yr i.regency_birth_esther95 sanitation_cohort d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 i.current_kab age agesq female academic_shift (educyr = intensity_cohort) 

ivregress 2sls fluidint i.dob_m_yr i.regency_birth_esther95 sanitation_cohort d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 i.current_kab age agesq female academic_shift (educyr = intensity_cohort)

ivregress 2sls numerical i.dob_m_yr i.regency_birth_esther95 sanitation_cohort d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 i.current_kab age agesq female academic_shift (educyr = intensity_cohort)

ivregress 2sls memory_episodic i.dob_m_yr i.regency_birth_esther95 sanitation_cohort d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 i.current_kab age agesq female academic_shift (educyr = intensity_cohort)

ivregress 2sls memory_intactness i.dob_m_yr i.regency_birth_esther95 sanitation_cohort d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 i.current_kab age agesq female academic_shift (educyr = intensity_cohort)



********************************************************************************

* Unrestricted sample * 
** trial **
// those born in 1957-1971

use "$finaldata/ifls5_school construction.dta", clear

keep if birth_year < 1973
drop if birth_year < 1958

gen exposure_status = 0 
replace exposure_status = 1 if birth_year > 1967
replace exposure_status = 2 if birth_year > 1962 & birth_year < 1968
replace exposure_status = 0 if birth_year < 1963

dtable educyr w_abil fluidint numerical memory_intactness, by(exposure_status) note(Source: IFLS, Ministry of Education and Culture) export("descriptive_stats", as(docx) replace)


gen exposed_cohort = 0
replace exposed_cohort = 1 if birth_year > 1962

gen instrument_inpres = high_intensity*exposed_cohort

gen intensity_cohort = school_intensity * exposed_cohort

gen sanitation_cohort = wsppc * exposed_cohort

gen java = 0 
replace java = 1 if regency12_esther95 > 3000 & regency12_esther95 < 4000

gen primary_school = 0
replace primary_school = 1 if level > 1 & grade == 7

gen female = 0
replace female = 1 if sex == 3

// create dummy year of birth 
gen d_1972 = 0 
replace d_1972 = 1 if dob_yr == 1972
gen d_1971 = 0
replace d_1971 = 1 if dob_yr == 1971
gen d_1970 = 0
replace d_1970 = 1 if dob_yr == 1970
gen d_1969 = 0
replace d_1969 = 1 if dob_yr == 1969
gen d_1968 = 0
replace d_1968 = 1 if dob_yr == 1968
gen d_1962 = 0
replace d_1962 = 1 if dob_yr == 1962
gen d_1961 = 0
replace d_1961 = 1 if dob_yr == 1961
gen d_1960 = 0
replace d_1960 = 1 if dob_yr == 1960
gen d_1959 = 0
replace d_1959 = 1 if dob_yr == 1959
gen d_1958 = 0
replace d_1958 = 1 if dob_yr == 1958

gen d_1972_en71 = d_1972 * en71
gen d_1971_en71 = d_1971 * en71
gen d_1970_en71 = d_1970 * en71
gen d_1969_en71 = d_1969 * en71
gen d_1968_en71 = d_1968 * en71
gen d_1962_en71 = d_1962 * en71
gen d_1961_en71 = d_1961 * en71
gen d_1960_en71 = d_1960 * en71
gen d_1959_en71 = d_1959 * en71
gen d_1958_en71 = d_1958 * en71

gen d_1972_ch71 = d_1972 * ch71
gen d_1971_ch71 = d_1971 * ch71
gen d_1970_ch71 = d_1970 * ch71
gen d_1969_ch71 = d_1969 * ch71
gen d_1968_ch71 = d_1968 * ch71
gen d_1962_ch71 = d_1962 * ch71
gen d_1961_ch71 = d_1961 * ch71
gen d_1960_ch71 = d_1960 * ch71
gen d_1959_ch71 = d_1959 * ch71
gen d_1958_ch71 = d_1958 * ch71


gen d_1972_saniation = d_1972 * wsppc
gen d_1971_saniation = d_1971 * wsppc
gen d_1970_sanitation = d_1970 * wsppc
gen d_1969_sanitation = d_1969 * wsppc
gen d_1968_sanitation = d_1968 * wsppc
gen d_1962_sanitation = d_1962 * wsppc
gen d_1961_sanitation = d_1961 * wsppc
gen d_1960_sanitation = d_1960 * wsppc
gen d_1959_sanitation = d_1959 * wsppc
gen d_1958_sanitation = d_1958 * wsppc

gen prop_child_1971 = ch71/pop71
gen d_1972_propch71 = d_1972 * prop_child_1971
gen d_1971_propch71 = d_1971 * prop_child_1971
gen d_1970_propch71 = d_1970 * prop_child_1971
gen d_1969_propch71 = d_1969 * prop_child_1971
gen d_1968_propch71 = d_1968 * prop_child_1971
gen d_1962_propch71 = d_1962 * prop_child_1971
gen d_1961_propch71 = d_1961 * prop_child_1971
gen d_1960_propch71 = d_1960 * prop_child_1971
gen d_1959_propch71 = d_1959 * prop_child_1971
gen d_1958_propch71 = d_1958 * prop_child_1971

gen religion_majority = 0
replace religion_majority = 1 if religion == 1
tab ethnic
gen ethnic_majority = 0
replace ethnic_majority = 1 if ethnic == 1


gen dob_m_yr = dob_mth * dob_yr

gen cohort_en71 = exposed_cohort * en71

gen cohort_ch71 = exposed_cohort * prop_child_1971


gen firstschool_year = agefirstschool + dob_yr

gen feeabolition = 0
replace feeabolition = 1 if firstschool_year > 1977

gen academic_shift = 0 
replace academic_shift = 1 if firstschool_year < 1978

duplicates drop pidlink, force

drop if regency_birth_esther95 > 9000




reg fluidint educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols1, title(Fluid Intelligence Raven's Test)

reg w_abil educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols2, title(Fluid Intelligence W-Score)

reg numerical educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust 
estimates store ols3, title(Numerical Ability)

reg memory_intactness educyr age agesq female ethnic_majority religion_majority i.dob_m_yr i.regency_birth_esther95, robust
estimates store ols4, title(Memory Intactness)

esttab ols1 ols2 ols3 ols4 using "$output/OLS_unrestricted.rtf, keep(educyr age agesq female _cons) se(%7.2f) b(%7.2f) ar2 


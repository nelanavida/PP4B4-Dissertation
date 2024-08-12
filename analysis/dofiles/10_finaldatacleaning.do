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
*					Create final data
*--------------------------------------------------------

use "$finaldata/ifls5_school construction.dta", clear

gen exposed_cohort = 0 
replace exposed_cohort = 1 if birth_year > 1967
replace exposed_cohort = 0 if birth_year < 1963 
replace exposed_cohort = . if dob_yr == . 

gen exposed_cohort_unrestricted = 0
replace exposed_cohort_unrestricted = 1 if dob_yr > 1962 
replace exposed_cohort_unrestricted = 0 if birth_year < 1963
replace exposed_cohort_unrestricted = . if dob_yr == . 

gen exposure_type = 0
replace exposure_type = 0 if dob_yr > 1957 & dob_yr < 1963 
replace exposure_type = 1 if dob_yr > 1962 & dob_yr < 1968
replace exposure_type = 2 if dob_yr < 1973 & dob_yr > 1967 


gen instrument_inpres = high_intensity*exposed_cohort

gen intensity_cohort = school_intensity * exposed_cohort

gen intensity_cohort_unrestricted = school_intensity * exposed_cohort_unrestricted

gen sanitation_cohort = wsppc * exposed_cohort

gen sanitation_cohort_unrestricted = wsppc * exposed_cohort_unrestricted

gen java = 0 
replace java = 1 if regency12_esther95 > 3000 & regency12_esther95 < 4000

gen primary_school = 0
replace primary_school = 1 if level > 1 & grade == 7

gen female = 0
replace female = 1 if sex == 3

// create dummy year of birth 
gen d_1977 = 0 
replace d_1977 = 1 if dob_yr == 1977
gen d_1976 = 0
replace d_1976 = 1 if dob_yr == 1976
gen d_1975 = 0
replace d_1975 = 1 if dob_yr == 1975
gen d_1974 = 0
replace d_1974 = 1 if dob_yr == 1974
gen d_1973 = 0
replace d_1973 = 1 if dob_yr == 1973

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

gen d_1967 = 0
replace d_1967 = 1 if dob_yr == 1967
gen d_1966 = 0
replace d_1966 = 1 if dob_yr == 1966
gen d_1965 = 0
replace d_1965 = 1 if dob_yr == 1965
gen d_1964 = 0
replace d_1964 = 1 if dob_yr == 1964
gen d_1963 = 0
replace d_1963 = 1 if dob_yr == 1963

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

gen d_1977_en71 = d_1977 * en71
gen d_1976_en71 = d_1976 * en71
gen d_1975_en71 = d_1975 * en71
gen d_1974_en71 = d_1974 * en71
gen d_1973_en71 = d_1973 * en71

gen d_1972_en71 = d_1972 * en71
gen d_1971_en71 = d_1971 * en71
gen d_1970_en71 = d_1970 * en71
gen d_1969_en71 = d_1969 * en71
gen d_1968_en71 = d_1968 * en71

gen d_1967_en71 = d_1967 * en71
gen d_1966_en71 = d_1966 * en71
gen d_1965_en71 = d_1965 * en71
gen d_1964_en71 = d_1964 * en71
gen d_1963_en71 = d_1963 * en71

gen d_1962_en71 = d_1962 * en71
gen d_1961_en71 = d_1961 * en71
gen d_1960_en71 = d_1960 * en71
gen d_1959_en71 = d_1959 * en71
gen d_1958_en71 = d_1958 * en71

gen d_1977_ch71 = d_1977 * ch71
gen d_1976_ch71 = d_1976 * ch71
gen d_1975_ch71 = d_1975 * ch71
gen d_1974_ch71 = d_1974 * ch71
gen d_1973_ch71 = d_1973 * ch71

gen d_1972_ch71 = d_1972 * ch71
gen d_1971_ch71 = d_1971 * ch71
gen d_1970_ch71 = d_1970 * ch71
gen d_1969_ch71 = d_1969 * ch71
gen d_1968_ch71 = d_1968 * ch71

gen d_1967_ch71 = d_1967 * ch71
gen d_1966_ch71 = d_1966 * ch71
gen d_1965_ch71 = d_1965 * ch71
gen d_1964_ch71 = d_1964 * ch71
gen d_1963_ch71 = d_1963 * ch71

gen d_1962_ch71 = d_1962 * ch71
gen d_1961_ch71 = d_1961 * ch71
gen d_1960_ch71 = d_1960 * ch71
gen d_1959_ch71 = d_1959 * ch71
gen d_1958_ch71 = d_1958 * ch71

replace wsppc = 0 if regency_birth_esther95 > 3100 & regency_birth_esther95 < 3200

gen d_1977_sanitation = d_1977 * wsppc
gen d_1976_sanitation = d_1976 * wsppc
gen d_1975_sanitation = d_1975 * wsppc
gen d_1974_sanitation = d_1974 * wsppc
gen d_1973_sanitation = d_1973 * wsppc

gen d_1972_sanitation = d_1972 * wsppc
gen d_1971_sanitation = d_1971 * wsppc
gen d_1970_sanitation = d_1970 * wsppc
gen d_1969_sanitation = d_1969 * wsppc
gen d_1968_sanitation = d_1968 * wsppc

gen d_1967_sanitation = d_1967 * wsppc
gen d_1966_sanitation = d_1966 * wsppc
gen d_1965_sanitation = d_1965 * wsppc
gen d_1964_sanitation = d_1964 * wsppc
gen d_1963_sanitation = d_1963 * wsppc

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

gen d_1967_propch71 = d_1967 * prop_child_1971
gen d_1966_propch71 = d_1966 * prop_child_1971
gen d_1965_propch71 = d_1965 * prop_child_1971
gen d_1964_propch71 = d_1964 * prop_child_1971
gen d_1963_propch71 = d_1963 * prop_child_1971

gen d_1962_propch71 = d_1962 * prop_child_1971
gen d_1961_propch71 = d_1961 * prop_child_1971
gen d_1960_propch71 = d_1960 * prop_child_1971
gen d_1959_propch71 = d_1959 * prop_child_1971
gen d_1958_propch71 = d_1958 * prop_child_1971


gen d_1977_intensity = d_1977 * school_intensity
gen d_1976_intensity = d_1976 * school_intensity
gen d_1975_intensity = d_1975 * school_intensity
gen d_1974_intensity = d_1974 * school_intensity
gen d_1973_intensity = d_1973 * school_intensity

gen d_1972_intensity = d_1972 * school_intensity
gen d_1971_intensity = d_1971 * school_intensity
gen d_1970_intensity = d_1970 * school_intensity
gen d_1969_intensity = d_1969 * school_intensity
gen d_1968_intensity = d_1968 * school_intensity

gen d_1967_intensity = d_1967 * school_intensity
gen d_1966_intensity = d_1966 * school_intensity
gen d_1965_intensity = d_1965 * school_intensity
gen d_1964_intensity = d_1964 * school_intensity
gen d_1963_intensity = d_1963 * school_intensity

gen d_1962_intensity = d_1962 * school_intensity
gen d_1961_intensity = d_1961 * school_intensity
gen d_1960_intensity = d_1960 * school_intensity
gen d_1959_intensity = d_1959 * school_intensity
gen d_1958_intensity = d_1958 * school_intensity

label var d_1972_intensity "1972"
label var d_1971_intensity "1971"
label var d_1971_intensity "1971"
label var d_1971_intensity "1971"
label var d_1970_intensity "1970"
label var d_1969_intensity "1969"
label var d_1968_intensity "1968"
label var d_1967_intensity "1967"
label var d_1966_intensity "1966"
label var d_1965_intensity "1965"
label var d_1964_intensity "1964"
label var d_1963_intensity "1963"
label var d_1962_intensity "1962"
label var d_1961_intensity "1961"
label var d_1960_intensity "1960"
label var d_1959_intensity "1959"
label var d_1958_intensity "1958"

gen religion_majority = 0
replace religion_majority = 1 if religion == 1
tab ethnic
gen ethnic_majority = 0
replace ethnic_majority = 1 if ethnic == 1

gen dob_m_yr = dob_mth * dob_yr

gen cohort_en71 = exposed_cohort * en71

gen cohort_ch71 = exposed_cohort * prop_child_1971


gen firstschool_year = agefirstschool + dob_yr
replace firstschool_year = .  if agefirstschool > 90

gen feeabolition = 0
replace feeabolition = 1 if firstschool_year > 1977

gen academic_shift = 0 
replace academic_shift = 1 if firstschool_year < 1979
replace academic_shift = 0 if firstschool_year < 1966

duplicates drop pidlink, force

drop if regency_birth_esther95 > 9000

gen agesq = age*age

save "$finaldata/final_data_ifls5.dta", replace


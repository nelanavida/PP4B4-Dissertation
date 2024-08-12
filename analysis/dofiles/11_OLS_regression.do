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
*					Analysis
*--------------------------------------------------------


use "$finaldata/final_data_ifls5.dta", clear

** descriptive statistics ** 

dtable educyr w_abil fluidint numerical memory_episodic memory_intactness if dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957, by(exposed_cohort) note(Source: IFLS, Ministry of Education and Culture) export("descriptive_stats_restricted", as(docx) replace)

dtable educyr w_abil fluidint numerical memory_episodic memory_intactness if dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968, by(exposure_type) note(Source: IFLS, Ministry of Education and Culture) export("descriptive_stats_unrestricted", as(docx) replace)

** OLS regression ** 

// OLS regression - restricted sample

reg fluidint educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957), robust
estimates store ols1_restricted, title(Fluid Intelligence Raven's Test)

reg w_abil educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957), robust
estimates store ols2_restricted, title(Fluid Intelligence W-Score)

reg numerical educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957), robust
estimates store ols3_restricted, title(Numerical Ability)

reg memory_episodic educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957), robust
estimates store ols4_restricted, title(Episodic Memory)

reg memory_intactness educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957), robust
estimates store ols5_restricted, title(Memory Intactness)

esttab ols1_restricted ols2_restricted ols3_restricted ols4_restricted ols5_restricted using "$output/result_OLS_restricted.rtf, replace keep(educyr) se(%7.2f) b(%7.2f) ar2 

// OLS regression - unrestricted sample


reg fluidint educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968), robust
estimates store ols1_unrestricted, title(Fluid Intelligence Raven's Test)

reg w_abil educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968), robust
estimates store ols2_unrestricted, title(Fluid Intelligence W-Score)

reg numerical educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968), robust
estimates store ols3_unrestricted, title(Numerical Ability)

reg memory_episodic educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968), robust
estimates store ols4_unrestricted, title(Episodic Memory)

reg memory_intactness educyr i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if (dob_yr < 1973 & dob_yr > 1967 | dob_yr < 1963 & dob_yr > 1957 | dob_yr > 1962 & dob_yr < 1968), robust
estimates store ols5_unrestricted, title(Memory Intactness)

esttab ols1_unrestricted ols2_unrestricted ols3_unrestricted ols4_unrestricted ols5_unrestricted using "$output/result_OLS_unrestricted.rtf", replace keep(educyr) se(%7.2f) b(%7.2f) ar2 







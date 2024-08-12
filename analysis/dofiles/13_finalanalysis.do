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
*					Analysis - Restricted
*--------------------------------------------------------

use "$finaldata/final_data_ifls5.dta", clear 

keep if birth_year < 1973
drop if birth_year > 1962 & birth_year < 1968
drop if birth_year < 1958

local control i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71

local instrument1 intensity_cohort 

local instrument2 intensity_cohort academic_shift

* instrument = intensity_cohort * 

ivregress 2sls fluidint i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls w_abil i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls numerical i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls memory_episodic i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 


ivregress 2sls memory_intactness i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 



** using additional instrument - academic shift 

ivregress 2sls fluidint i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls w_abil i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls numerical i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 

ivregress 2sls memory_episodic i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls memory_intactness i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 

** first stage OLS ** 

reg educyr intensity_cohort i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71, robust
estimate store firststage_pool_model1, title(All sample)

reg educyr intensity_cohort  i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 1, robust
estimate store firststage_femalemodel1, title(Female)

reg educyr intensity_cohort i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 0, robust
estimate store firststage_malemodel1, title(Male)

esttab firststage_pool_model1 firststage_malemodel1 firststage_femalemodel1  using "$output/result_firststage_model1.rtf", replace keep(intensity_cohort) se(%7.2f) b(%7.2f) ar2 

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71, robust
estimate store firststage_pool, title(All sample)

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 1, robust
estimate store firststage_pool_female, title(Female)

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 0, robust
estimate store firststage_pool_male, title(Male)

esttab firststage_pool firststage_pool_male firststage_pool_female using "$output/result_OLS_firststage.rtf", replace keep(intensity_cohort academic_shift) se(%7.2f) b(%7.2f) ar2 



*--------------------------------------------------------
*				Analysis - Unrestricted
*--------------------------------------------------------

use "$finaldata/final_data_ifls5.dta", clear 

keep if birth_year < 1973
drop if birth_year > 1962 & birth_year < 1968
drop if birth_year < 1958

local control i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71

local instrument1 intensity_cohort 

local instrument2 intensity_cohort academic_shift

* instrument = intensity_cohort * 

ivregress 2sls fluidint i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls w_abil i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls numerical i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 

ivregress 2sls memory_episodic i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 


ivregress 2sls memory_intactness i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort), robust

estat firststage 



** using additional instrument - academic shift 

ivregress 2sls fluidint i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls w_abil i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls numerical i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 

ivregress 2sls memory_episodic i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 


ivregress 2sls memory_intactness i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 (educyr = intensity_cohort academic_shift), robust
estat firststage 

** first stage OLS ** 

reg educyr intensity_cohort i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71, robust
estimate store firststage_pool_model1, title(All sample)

reg educyr intensity_cohort  i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 1, robust
estimate store firststage_femalemodel1, title(Female)

reg educyr intensity_cohort i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 0, robust
estimate store firststage_malemodel1, title(Male)

esttab firststage_pool_model1 firststage_malemodel1 firststage_femalemodel1  using "$output/result_firststage_model1.rtf", replace keep(intensity_cohort) se(%7.2f) b(%7.2f) ar2 

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71, robust
estimate store firststage_pool, title(All sample)

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 1, robust
estimate store firststage_pool_female, title(Female)

reg educyr intensity_cohort academic_shift i.dob_m_yr i.regency_birth_esther95 age agesq female d_1972_ch71 d_1971_ch71 d_1970_ch71 d_1969_ch71 d_1968_ch71 d_1962_ch71 d_1961_ch71 d_1960_ch71 d_1959_ch71 d_1972_saniation d_1971_saniation d_1970_sanitation d_1969_sanitation d_1968_sanitation d_1962_sanitation d_1961_sanitation d_1960_sanitation d_1959_sanitation d_1972_en71 d_1971_en71 d_1970_en71 d_1969_en71 d_1968_en71 d_1962_en71 d_1961_en71 d_1960_en71 d_1959_en71 if female == 0, robust
estimate store firststage_pool_male, title(Male)

esttab firststage_pool firststage_pool_male firststage_pool_female using "$output/result_OLS_firststage.rtf", replace keep(intensity_cohort academic_shift) se(%7.2f) b(%7.2f) ar2 


*================================================================================
*  Reap What You Sow: Education and Long-term Cognitive Ability Impact     
*           		 Nela Navida - MPA LSE 2024
*================================================================================

clear all
capture log close
discard

*storage
*input 

cd "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/Sekolah STATA/Spatial Econometrics/01_data"

//Konversi

spshape2dta petakab, replace

//Panggila data peta yang sudah dibuat
use petakab, clear

// Hanya 3 variabel yang harus ada, yaitu _ID, _CY, dan _CY
keep _* A1N_BPS A2C_BPS A2N_BPS Type
ren A1N_BPS prov 
ren A2C_BPS idkab 
ren A2N_BPS kab 
ren Type kabkota

la var prov "Provinsi"
la var idkab "id kabupaten/kota"
la var kab "Nama kabupaten"
la var kabkota "kabupaten/kota"

format %4.0f idkab

//Buat dummy kota
encode kabkota, gen(kota)
recode kota (1 2 =0 ) (3 4=1), gen(dkota)
drop kota
la var dkota "dummy kota"
ren idkab codekab
//Pastikan jarak dalam kilometer
spset, modify coordsys(latlong, kilometers)

save "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/Sekolah STATA/Spatial Econometrics/01_data/petakab.dta", replace

//activate grmap
grmap, activate

//Cek peta dasar 
grmap _ID , clnumber(9) fcolor(white) mosize(vvthin )


use "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/Sekolah STATA/Spatial Econometrics/01_data/cleaned_schoolconst.dta", clear

merge 1:m regency12_esther95 using "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/MPA LSE/Year 2/PP4B4 Dissertation/Data/Analysis/intdata/regency_esther95.dta"
drop _merge

gen codekab = regency12_bps14


save "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/Sekolah STATA/Spatial Econometrics/01_data/sdinpres.dta", replace 

merge m:1 codekab using "/Users/nelanavida/Library/CloudStorage/OneDrive-Personal/Activities/Sekolah STATA/Spatial Econometrics/01_data/petakab.dta"
keep if _merge==3
drop _merge

duplicates drop _ID, force

// Simpan data gabungan antara peta dan data lain 
save "Data merge all.dta", replace

// create the map

grmap school_intensity , clnumber(5) fcolor(Reds)	
graph export distribusi_sdinpres.png, replace



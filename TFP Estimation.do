****************************************************
************ Productivity Estimation ***************
****************************************************

use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Basic data of listed companies in 2023/GTA2023final.dta", clear

**keep only the relevant variables**
keep id id_org year Sicda A001000000 C001014000 C001001000 Y0601b //id, year, industry code, total assets (k), cash to intermediates (m), total sales (y), number of employees (l)

**gen logged variables**
gen lnk = ln(A001000000)
gen lnm = ln(C001014000)
gen lny = ln(C001001000)
gen lnl = ln(Y0601b)

drop A001000000 C001014000 C001001000 Y0601b

**narrow to years above 2008, to fit subsidy data timeframe; below 2020 to fit with land transactions timeframe +- 1 year for lagged var
drop if year < 2006 | year > 2020

save "/Users/maggiewang/Downloads/Year_4/Thesis/listedtfp.dta", replace

use "/Users/maggiewang/Downloads/Year_4/Thesis/listedtfp.dta"
ssc install prodest 
xtset id year
prodest lny, method (wrdg) free(lnl) proxy(lnm) state(lnk) valueadded attrition overidentification gmm
predict tfp, residuals

keep id year tfp lny lnl lnm lnk
save "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/listedtfp.dta", replace

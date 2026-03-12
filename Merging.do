**MERGING**
use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Basic data of listed companies in 2023/GTA2023final.dta", clear

merge 1:1 id year using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/credit subsidies.dta"
drop _merge

merge 1:1 id year using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/tax subsidies.dta"
drop _merge

merge 1:1 id year using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/listedtfp.dta"
drop _merge

merge 1:1 id year using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/direct subsidy.dta"
drop _merge

// merge 1:1 id year using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/AETCmerge.dta"
drop if year < 2006 | year > 2020


keep id year Sicda TA owner_type L_sl L_fin_lev L_lnassets L_itang L_daratio enir credit aghion tfp gov_subsidy Estbyear_13 B001000000 size lny lnl lnm lnk Sale Y0601b Y0501b

**Construct Variables**
gen firm_size = ln(Sale + 1)
gen age = year-Estbyear_13
gen profitability = B001000000/TA

**Create lagged variables
xtset id year
gen Ltfp = L.tfp
gen Lsize = L.firm_size
gen Lprofitability = L.profitability
gen Lemployment = L.Y0601b

rename Y0601b employment
rename B001000000 tot_profit
rename aghion tax_subsidy
rename Y0501b top10party

**Create total subsidy
gen agg_subsidy = gov_subsidy + tax_subsidy + credit 

//TFP, firm age, firm sector, firm size, profitability, employment

**recode top10party
replace top10party = 0 if top10party == 1
replace top10party = 1 if top10party == 2
replace top10party = . if top10party == 3

merge m:1 id using "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/2002connectionmerge.dta"
drop _merge
// merge m:1 id using  "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/2012connectmerge.dta"

//create SOE var
replace owner_type = 0 if owner_type > 1

save "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/merged.dta", replace

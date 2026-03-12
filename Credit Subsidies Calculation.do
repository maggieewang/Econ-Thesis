****************************************************
*********** Generating Credit Subsidy **************
****************************************************
use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Basic data of listed companies in 2023/GTA2023final.dta", clear
keep id id_org year Sicda A002114000 Enddebt_33 Ownership_101_p tl sl ll F070101B F070201B F070301B TA itang F011201A

drop if year < 2006 | year > 2020

rename A002114000 int_payable //interest payable
rename Enddebt_33 int_liability //Interest-Bearing Liabilities at End of Period - [Special Topic - Capital Structure]
rename Ownership_101_p owner_type 
rename F070101B	fin_lev //Financial Leverage
rename F070201B	op_lev	//Operating Leverage
rename F070301B	comb_lev //Combined Leverage

rename TA assets //Total Assets

//tl = Total Debt Ratio = Total Liabilities / Total Assets
//sl = Short-Term Debt Ratio = Total Current Liabilities / Total Assets
//ll = Long-Term Debt Ratio = Total Long-Term Liabilities / Total Assets

//itang = Intangible Assets Ratio = Net Intangible Assets / Total Assets

rename F011201A	daratio	//Debt-to-Asset Ratio

**Create lagged variables of each financial variable, + ln(asset size)
gen lnassets = ln(assets)
drop assets

xtset id year
**Lag: tl sl ll fin_lev op_lev comb_lev lnassets itang daration
foreach var in tl sl ll fin_lev op_lev comb_lev lnassets itang daratio int_liability {
    gen L_`var' = L.`var'
}

**Create dependent variable: effective nominal interest rate
gen enir = int_payable/L_int_liability

**Choices: fin_lev, op_lev, comb_lev and sl, tl, ll. Run multiple regressions as robustness checks:
reghdfe enir Sicda owner_type L_sl L_fin_lev L_lnassets L_itang L_daratio, absorb (year) residuals(credit)

keep enir Sicda owner_type L_sl L_fin_lev L_lnassets L_itang L_daratio year id credit
save "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/credit subsidies.dta", replace

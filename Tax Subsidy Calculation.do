****************************************************
************* Generating Tax Subsidy ***************
****************************************************
use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Basic data of listed companies in 2023/GTA2023final.dta", clear

keep id id_org year Sicda A001222000 A002208000 C001012000 C001021000 F032801B F050801B F050601B F110101B C003003000 A001119000 Bbd1102101 C0f1009000 B001302000 B002000000 B001000000

rename A001222000 def_tassets //deferred tax assets
rename A002208000 def_tliabilities //deferred tax liabilities
rename C001012000 tax_refund // tax refunds received
rename C001021000 tax_paid // tax paid
rename F032801B income_trate // income tax rate
rename F050801B ebitda // Earnings Before Interest, Taxes, Depreciation, and Amortization
rename F050601B ebit // Earnings Before Interest, Taxes
rename F110101B cash_div // Pre-tax cash dividend per share
rename C003003000 cash_bond // Cash received from issuance of bonds
// rename A001119000 interest_receive // Net interest receivable
rename Bbd1102101 interest_inc // Interest Income
// rename C0f1009000 cash_fromint // Cash Received from Interest, Fees, and Commissions
rename B001302000 inv_inc // Investment Income
rename B002000000 net_profit
rename B001000000 total_profit

**narrow to years above 2008, to fit subsidy data timeframe; below 2020 to fit with land transactions timeframe +- 1 year for lagged var
drop if year < 2006 | year > 2020

gen ETR = ((total_profit*income_trate) + def_tassets - def_tliabilities)/(ebit + cash_div + cash_bond - inv_inc)

**aghion tax holiday estimation
gen aghion = (total_profit * 0.25) - (total_profit*income_trate) + tax_refund

keep id year aghion

save "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/tax subsidies.dta", replace

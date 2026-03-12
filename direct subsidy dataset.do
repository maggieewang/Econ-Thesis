**Direct Subsidy Dataset**
use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Collection of Subsidy Data for Listed Companies (2007-2023)/2007-2023 Panel data on subsidies for listed firms eng labels.dta"

keep stkcd year gov_subsidy
rename stkcd id 
save "/Users/maggiewang/Downloads/Year_4/Thesis/direct subsidy.dta", replace

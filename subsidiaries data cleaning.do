********************************************************************************
************************DATA CLEANING FOR SUBSIDIARIES**************************
********************************************************************************

use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Subsidaries/参控股公司列表_1.dta", clear

*** Renaming ***
rename 股票代码 stkcd
rename 会计年度 year
rename 序号 id
rename 参控股公司名称 holding_comp
rename 参控关系 relation
rename 参控比例 own_pct
rename 被参控股公司注册资本 reg_capital_10k
rename 货币单位 currency

*** Destring ***
destring own_pct, ignore ("%") percent replace
destring reg_capital_10k, ignore ("万元") replace

save "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Subsidaries/参控股公司列表_1.dta", replace

use "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Subsidaries/参控股公司列表_2.dta", clear

*** Renaming ***
rename 股票代码 stkcd
rename 会计年度 year
rename 序号 id
rename 参控股公司名称 holding_comp
rename 参控关系 relation
rename 参控比例 own_pct
rename 被参控股公司注册资本 reg_capital_10k
rename 货币单位 currency

*** Destring ***
destring stkcd, replace
destring own_pct, ignore ("%") percent replace
destring reg_capital_10k, ignore ("万元") replace

save "/Users/maggiewang/Downloads/Year_4/Thesis/Shengqiao shared data/Subsidaries/参控股公司列表_2.dta", replace

**simplify**
use "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/merged.dta"
keep id year ListedCoID_11 

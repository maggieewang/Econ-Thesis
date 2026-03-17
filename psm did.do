
use "/Users/maggiewang/Downloads/Year_4/Thesis/Data Merging/merged.dta", clear
xtset id year

//gen connection2002 dummy var
 gen connect2002 = .
replace connect2002 = 1 if numberofpeoplewithconnections > 0
replace connect2002 = 0 if numberofpeoplewithconnections == 0

**descriptive statistics
reghdfe credit owner_type top10party connect2002 Ltfp age Sicda Lsize Lprofitability Lemployment, absorb (year)
reghdfe tax_subsidy owner_type top10party connect2002 Ltfp age Sicda Lsize Lprofitability Lemployment, absorb (year)
reghdfe gov_subsidy owner_type top10party connect2002 Ltfp age Sicda Lsize Lprofitability Lemployment, absorb (year)
reghdfe tfp top10party Sicda age Lsize Lprofitability Lemployment, absorb (year)
reghdfe tfp owner_type Sicda age Lsize Lprofitability Lemployment, absorb (year)
reghdfe tfp connect2002 Sicda age Lsize Lprofitability Lemployment, absorb (year)

**PSM
//setup
gen obs_id = _n

//run credit regression first
//reg1
 teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
 gen mc1_id = obs_id[_m1] if !missing(_m1)
 gen mc1 = 0
replace mc1 = 1 if !missing(_m1)   // treated
replace mc1 = 1 if inlist(obs_id, mc1_id)

drop _m1
 //reg2
 teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen mc2_id = obs_id[_m1] if !missing(_m1)
 gen mc2 = 0
replace mc2 = 1 if !missing(_m1)   // treated
replace mc2 = 1 if inlist(obs_id, mc2_id)
 drop _m1

// gen natgov_d   = (nationalpartygovernmentcareer > 0)
// gen locgov_d   = (localpartygovernmentcareerinclud > 0)
// gen outgov_d   = (outsidepartgovernmentycareer > 0)
// gen natpar_d   = (memberofnationalparliament > 0)
// gen locpar_d   = (memberoflocalparliamentincludeou > 0)
// gen outpar_d   = (outsideparliamentcareer > 0)
// gen natcong_d  = (memberofnationalpartycongress > 0)
// gen loccong_d  = (memberoflocalpartycongressinclud > 0)
// gen outcong_d  = (outsidepartycongressmember > 0)
// gen mil_d      = (militarycareer > 0)
//
// //test each connection type
// teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (natgov_d), atet
// foreach treat in locgov_d outgov_d natpar_d locpar_d outpar_d ///
//                  natcong_d loccong_d outcong_d mil_d {
//
//     teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (`treat'), atet
// }

//reg3
teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
gen mc3_id = obs_id[_m1] if !missing(_m1)
 gen mc3 = 0
replace mc3 = 1 if !missing(_m1)   // treated
replace mc3 = 1 if inlist(obs_id, mc3_id)
 drop _m1

//tax propensity
teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
gen mt1_id = obs_id[_m1] if !missing(_m1)
 gen mt1 = 0
replace mt1 = 1 if !missing(_m1)   // treated
replace mt1 = 1 if inlist(obs_id, mt1_id)
drop _m1

 teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen mt2_id = obs_id[_m1] if !missing(_m1)
 gen mt2 = 0
replace mt2 = 1 if !missing(_m1)   // treated
replace mt2 = 1 if inlist(obs_id, mt2_id)
 drop _m1
 
 teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
 gen mt3_id = obs_id[_m1] if !missing(_m1)
 gen mt3 = 0
replace mt3 = 1 if !missing(_m1)   // treated
replace mt3 = 1 if inlist(obs_id, mt3_id)
 drop _m1
 
//direct psm
teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
gen md1_id = obs_id[_m1] if !missing(_m1)
 gen md1 = 0
replace md1 = 1 if !missing(_m1)   // treated
replace md1 = 1 if inlist(obs_id, md1_id)
 drop _m1
 
 teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen md2_id = obs_id[_m1] if !missing(_m1)
 gen md2 = 0
replace md2 = 1 if !missing(_m1)   // treated
replace md2 = 1 if inlist(obs_id, md2_id)
 drop _m1
 
 teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
 gen md3_id = obs_id[_m1] if !missing(_m1)
 gen md3 = 0
replace md3 = 1 if !missing(_m1)   // treated
replace md3 = 1 if inlist(obs_id, md3_id)
 drop _m1
 
**DiD
gen post = (year >= 2012) 

gen top10party_i = 0
replace top10party_i = 1 if top10party == 1
gen top10party_post = top10party_i*post

gen soe_i = 0
replace soe_i = 1 if owner_type == 1
gen soe_post = soe_i*post

gen connect2002_i = 0
replace connect2002_i = 1 if connect2002 == 1
gen connect2002_post = connect2002_i*post

//credit
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)

//tax_subsidy
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)

//direct
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)

**DiD w/ PSM
//credit
preserve
keep if mc1 == 1
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party*post), group (id) time(year)
restore

preserve
keep if mc2 == 1
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (soe*post), group (id) time(year)
restore

preserve
keep if mc3 == 1
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002*post), group (id) time(year)
restore

//tax_subsidy
preserve
keep if mt1 == 1
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party*post), group (id) time(year)
restore

preserve
keep if mt2 == 1
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (soe*post), group (id) time(year)
restore

preserve
keep if mt3 == 1
xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002*post), group (id) time(year)
restore

//direct
preserve
keep if md1 == 1
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party*post), group (id) time(year)
restore

preserve
keep if md2 == 1
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (soe*post), group (id) time(year)
restore

preserve
keep if md3 == 1
xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002*post), group (id) time(year)
restore


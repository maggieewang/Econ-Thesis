
use "/Users/maggiewang/Downloads/Year_4/Thesis/Data Work/Data Merging/merged.dta", clear
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
******reg1: top10party********
 teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
 gen mc1_id = obs_id[_m1] if !missing(_m1)
 gen mc1 = 0
replace mc1 = 1 if !missing(_m1)   // treated
replace mc1 = 1 if inlist(obs_id, mc1_id)
drop _m1

//compute %ATT: 
sum credit if mc1 == 0 //avg Y_0
display .0421065/.0295711 //returns %ATTc1 = 1.4239071

******reg2: owner_type********
 teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen mc2_id = obs_id[_m1] if !missing(_m1)
 gen mc2 = 0
replace mc2 = 1 if !missing(_m1)   // treated
replace mc2 = 1 if inlist(obs_id, mc2_id)
 drop _m1
 
//compute %ATT: 
sum credit if mc1 == 0 //avg Y_0
display -.0209181/.0295711 //returns %ATTc2 = -.70738322

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

******reg3: connect2002********
teffects nnmatch (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
gen mc3_id = obs_id[_m1] if !missing(_m1)
 gen mc3 = 0
replace mc3 = 1 if !missing(_m1)   // treated
replace mc3 = 1 if inlist(obs_id, mc3_id)
 drop _m1
 
 //compute %ATT: 
display .0582647/.0295711 //returns %ATTc3 = 1.9703258 

//tax propensity
teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
gen mt1_id = obs_id[_m1] if !missing(_m1)
 gen mt1 = 0
replace mt1 = 1 if !missing(_m1)   // treated
replace mt1 = 1 if inlist(obs_id, mt1_id)
drop _m1

 //compute %ATT: 
 sum tax_subsidy if mc1 == 0 //avg Y_0
display  1.94e+07/7.62e+07 //returns %ATTt1 = .25459318

 teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen mt2_id = obs_id[_m1] if !missing(_m1)
 gen mt2 = 0
replace mt2 = 1 if !missing(_m1)   // treated
replace mt2 = 1 if inlist(obs_id, mt2_id)
 drop _m1
 
//compute %ATT: 
display -5.57e+07/7.62e+07 //returns %ATTt2 = -.73097113

 teffects nnmatch (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
 gen mt3_id = obs_id[_m1] if !missing(_m1)
 gen mt3 = 0
replace mt3 = 1 if !missing(_m1)   // treated
replace mt3 = 1 if inlist(obs_id, mt3_id)
 drop _m1
 
 //compute %ATT: 
display 2.04e+07/7.62e+07 //returns %ATTt3 = .26771654
 
//direct psm
teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party), atet generate(_m)
gen md1_id = obs_id[_m1] if !missing(_m1)
 gen md1 = 0
replace md1 = 1 if !missing(_m1)   // treated
replace md1 = 1 if inlist(obs_id, md1_id)
 drop _m1
 
 //compute %ATT: 
 sum gov_subsidy if mc1 == 0 //avg Y_0
display 9460363/2.77e+07 //returns %ATTd1 = .34152935

 teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (owner_type), atet generate(_m)
 gen md2_id = obs_id[_m1] if !missing(_m1)
 gen md2 = 0
replace md2 = 1 if !missing(_m1)   // treated
replace md2 = 1 if inlist(obs_id, md2_id)
 drop _m1
 
 //compute %ATT: 
display 1134621/2.77e+07 //returns %ATTd1 = .04096105
 
 teffects nnmatch (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment) (connect2002), atet generate(_m)
 gen md3_id = obs_id[_m1] if !missing(_m1)
 gen md3 = 0
replace md3 = 1 if !missing(_m1)   // treated
replace md3 = 1 if inlist(obs_id, md3_id)
 drop _m1
 
  //compute %ATT: 
display 1.06e+07/2.77e+07 //returns %ATTd1 = .38267148
 
**DiD
gen post = (year >= 2012) 

gen top10party2011 = (top10party == 1 & year == 2011)
bysort id: egen top10party_i = max(top10party2011)
gen top10party_post = top10party_i*post

replace top10party_i = 0
replace top10party_i = 1 if top10party == 1
replace top10party_post = top10party_i*post


gen soe_i = 0
replace soe_i = 1 if owner_type == 1
gen soe_post = soe_i*post

gen connect2002_i = 0
replace connect2002_i = 1 if connect2002 == 1
gen connect2002_post = connect2002_i*post

// //credit
// xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
// xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
// xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)
//
// //tax_subsidy
// xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
// xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
// xtdidregress (tax_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)
//
// //direct
// xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment top10party post) (top10party*post), group (id) time(year)
// xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment owner_type post) (soe*post), group (id) time(year)
// xtdidregress (gov_subsidy Ltfp age Sicda Lsize Lprofitability Lemployment connect2002 post) (connect2002*post), group (id) time(year)

**DiD w/ PSM
//credit
preserve
keep if mc1 == 1
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (top10party_post), group (id) time(year) 

//compute %ATT: 
 sum credit if top10party == 0 & post == 1 //avg Y_0
display .0617708/-.0784722 //-.78716794

// csdid credit Ltfp age Sicda Lsize Lprofitability Lemployment, ivar(id) time(year) gvar(t10party)
// gen t10party = 2012*top10party_post

restore

preserve
keep if mc2 == 1
xtdidregress (credit Ltfp age Sicda Lsize Lprofitability Lemployment) (soe*post), group (id) time(year)
//compute %ATT: 
 sum credit if soe == 0 & post == 1 //avg Y_0
display .0617708/-.0784722 //-.78716794

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

//TFP

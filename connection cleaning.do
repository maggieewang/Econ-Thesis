********************************************************************************
***************** Connection Indicator 1: Constructed Dataset ******************
********************************************************************************
import delimited using "/Users/maggiewang/Downloads/Year_4/Thesis/dataverse_files (2)/coded data/2002 connections.csv"
// replace badly translated lines
replace location = "121.418461,31.399794" in 932
replace longitude = "121.418461" in 932
replace latitude = "31.399794" in 932
replace pro_n = 9 in 932
replace province_chi = "上海市" in 932
replace province = "Shanghai" in 932
replace prefecture = "宝山区" in 932
drop in 933

replace location = "121.489973,31.236107" in 1221
replace longitude = "121.489973" in 1221
replace latitude = "31.236107" in 1221
replace pro_n = 9 in 1221
replace province_chi = "上海市" in 1221
replace province = "Shanghai" in 1221
replace prefecture = "黄浦区" in 1221
drop in 1222

replace location = "121.70742,31.168398" in 2191
replace longitude = "121.70742" in 2191
replace latitude = "31.168398" in 2191
replace pro_n = 9 in 2191
replace province_chi = "上海市" in 2191
replace province = "Shanghai" in 2191
replace prefecture = "浦东新区" in 2191
drop in 2192


replace location = "121.356088,31.220665" in 2246
replace longitude = "121.356088" in 2246
replace latitude = "31.220665" in 2246
replace pro_n = 9 in 2246
replace province_chi = "上海市" in 2246
replace province = "Shanghai" in 2246
replace prefecture = "长宁区" in 2246
drop in 2247

save "/Users/maggiewang/Downloads/Year_4/Thesis/dataverse_files (2)/coded data/2002 connections.dta"

******

import delimited using "/Users/maggiewang/Downloads/Year_4/Thesis/dataverse_files (2)/coded data/1993 connections.csv"

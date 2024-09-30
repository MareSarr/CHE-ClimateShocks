******************************************************************************************
***** Catastrophic Health Expenditures in a Changing Climate: A Tanzanian Case Study *****
******************************************************************************************



use  "CHE&ClimateShocks.dta", clear

*Table 1: Descriptive statistics
***============================================================================================================================================================== 
***============================================================================================================================================================== 

asdoc sum budget_share afs_share pnsf_share normsfhu che_budgetshare10 che_budgetshare25 che_afsshare25  che_afsshare40  che_pnsfshare40  che_normsfhu40  shock_healthevent shock_climate  wealth_quintile age60  education_Father hhsize marital_status_rec hh_locality_rec   climate_risk_regions 


*Table 2: CHE Incidence, Intensity and Inequality
***============================================================================================================================================================== 
***============================================================================================================================================================== 

asdoc cixr wealth_quintile che_budgetshare10, replace 
asdoc cixr wealth_quintile che_budgetshare25
asdoc cixr wealth_quintile che_afsshare25
asdoc cixr wealth_quintile che_afsshare40
asdoc cixr wealth_quintile che_pnsfshare40 
asdoc cixr wealth_quintile che_normsfhu40 

*Overshooting and Mean positive overshooting (MPO)
* Define your threshold (example: 10%)
sum budget_share afs_share pnsf_share normsfhu  

local threshold10 = 0.10 
local threshold25 = 0.25
local threshold40 = 0.40

* Headcount (H)
gen headcount_bs10 = budget_share > 0.1
gen headcount_bs25 = budget_share > 0.25
gen headcount_AF25 = afs_share > 0.25
gen headcount_AF40 = afs_share > 0.4
gen headcount_pnf40 = pnsf_share > 0.4
gen headcount_norm40 = normsfhu > 0.4

sum headcount_bs10
local HC_bs10 = r(mean) * 100

sum headcount_bs25
local HC_bs25 = r(mean) * 100

sum headcount_AF25
local HC_AF25 = r(mean) * 100

sum headcount_AF40
local HC_AF40 = r(mean) * 100

sum headcount_pnf40
local HC_pnf40 = r(mean) * 100

sum headcount_norm40
local HC_norm40 = r(mean) * 100

display "headcount_bs10: " `HC_bs10' "%"
display "headcount_bs25: " `HC_bs25' "%"
display "headcount_AF25: " `HC_AF25' "%"
display "headcount_AF40: " `HC_AF40' "%"
display "headcount_pnf40: " `HC_pnf40' "%"
display "headcount_norm40: " `HC_norm40' "%"

* Standard errors via bootstrapping HC
bootstrap HC_bs10=r(mean), reps(1000): sum headcount_bs10
bootstrap HC_bs25=r(mean), reps(1000): sum headcount_bs25
bootstrap HC_AF25=r(mean), reps(1000): sum headcount_AF25
bootstrap HC_AF40=r(mean), reps(1000): sum headcount_AF40
bootstrap HC_pnf40=r(mean), reps(1000): sum headcount_pnf40
bootstrap HC_norm40=r(mean), reps(1000): sum headcount_norm40

* Calculate overshooting
gen overshoot_BS10 = max(0, budget_share  - 0.1)
gen overshoot_BS25 = max(0, budget_share - 0.25)
gen overshoot_AFS25 = max(0, afs_share - 0.25)
gen overshoot_AFS40 = max(0, afs_share - 0.4)
gen overshoot_pnf40 = max(0, pnsf_share - 0.4)
gen overshoot_norm40 = max(0, normsfhu - 0.4)


sum overshoot_BS10
local O_BS10 = r(mean) * 100

sum overshoot_BS25
local O_BS25 = r(mean) * 100

sum overshoot_AFS25
local O_AFS25 = r(mean) * 100

sum overshoot_AFS40
local O_AFS40 = r(mean) * 100

sum overshoot_pnf40
local O_pnf40 = r(mean) * 100

sum overshoot_norm40
local O_norm40 = r(mean) * 100


display "overshoot_BS10: " `O_BS10' "%"
display "overshoot_BS25: " `O_BS25' "%"
display "overshoot_AFS25: " `O_AFS25' "%"
display "overshoot_AFS40: " `O_AFS40' "%"
display "overshoot_pnf40: " `O_pnf40' "%"
display "overshoot_norm40: " `O_norm40' "%"

* Standard errors via bootstrapping Overshoot
bootstrap O_BS10=r(mean), reps(1000): sum overshoot_BS10
bootstrap O_BS25=r(mean), reps(1000): sum overshoot_BS25
bootstrap O_AFS25=r(mean), reps(1000): sum overshoot_AFS25
bootstrap O_AFS40=r(mean), reps(1000): sum overshoot_AFS40
bootstrap O_pnf40=r(mean), reps(1000): sum overshoot_pnf40
bootstrap O_norm40=r(mean), reps(1000): sum overshoot_norm40

* Mean Positive Overshoot (MPO)
sum overshoot_BS10 if overshoot_BS10 > 0
local MPO_BS10 = r(mean) * 100

sum overshoot_BS25 if overshoot_BS25 > 0
local MPO_BS25 = r(mean) * 100

sum overshoot_AFS25 if overshoot_AFS25 > 0
local MPO_BAFS25 = r(mean) * 100

sum overshoot_AFS40 if overshoot_AFS40 > 0
local MPO_AFS40 = r(mean) * 100

sum overshoot_pnf40 if overshoot_pnf40 > 0
local MPO_pnf40 = r(mean) * 100

sum overshoot_norm40 if overshoot_norm40 > 0
local MPO_norm40 = r(mean) * 100

display " Mean Positive Overshoot MPO_BS10: " `MPO_BS10' "%"
display "Mean Positive Overshoot MPO_BS25: " `MPO_BS25' "%"
display "Mean Positive Overshoot MPO_BAFS25: " `MPO_BAFS25' "%"
display "Mean Positive Overshoot MPO_AFS40: " `MPO_AFS40' "%"
display "Mean Positive Overshoot MPO_pnf40: " `MPO_pnf40' "%"
display "Mean Positive Overshoot MPO_norm40: " `MPO_norm40' "%"

* Standard errors via bootstrapping MPO
bootstrap MPO_BS10=r(mean), reps(1000): sum overshoot_BS10 if overshoot_BS10 > 0
bootstrap MPO_BS25=r(mean), reps(1000): sum overshoot_BS25 if overshoot_BS25 > 0
bootstrap MPO_BAFS25=r(mean), reps(1000): sum overshoot_AFS25 if overshoot_AFS25 > 0
bootstrap MPO_AFS40=r(mean), reps(1000): sum overshoot_AFS40 if overshoot_AFS40 > 0
bootstrap MPO_pnf40=r(mean), reps(1000): sum overshoot_pnf40 if overshoot_pnf40 > 0
bootstrap MPO_norm40=r(mean), reps(1000): sum overshoot_norm40 if overshoot_norm40 > 0



*Figure 1: Distribution of health burden  by wealth quintiles 
***============================================================================================================================================================== 
***============================================================================================================================================================== 

* Define health burden variables 
local health_vars "budget_share afs_share pnsf_share normsfhu"

* Generate summary statistics
foreach var of local health_vars {
    display _n "Summary statistics for `var':"
    tabstat `var', by(wealth_quintile) statistics(n mean sd min p25 p50 p75 max) columns(statistics) longstub format(%9.4f)
}

* Create box plots
foreach var of local health_vars {
    graph box `var', over(wealth_quintile) title("Distribution of `var' by Wealth Category") ///
        subtitle("Box plot") ytitle("`var'") name(`var'_boxplot, replace)
		graph save "`var'_boxplot.gph", replace
}

* Combine all box plots into a single graph
graph combine budget_share_boxplot.gph afs_share_boxplot.gph pnsf_share_boxplot.gph normsfhu_boxplot.gph, ///
    rows(2) cols(2) title("Health Burden Distributions by Wealth Category")
	
*=================================================================================================================================================

*Figure 2: Concentration curves - Distribution of Health Expenditure Burden Across Wealth Groups

lorenz budget_share afs_share pnsf_share normsfhu, pvar(wealth_quintile)graph(overlay aspectratio(1) xlabels(,grid) legend(cols(1))noci) 

*=================================================================================================================================================

*Figure 3: Lorenz Curves - Distribution of Health Expenditure Burden by Climate Shocks
***============================================================================================================================================================== 
lorenz estimate  budget_share, over (shock_climate) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(g1, replace) title("Panel (a)")
lorenz estimate  afs_share, over(shock_climate) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(g2, replace) title("Panel (b)")

lorenz estimate  pnsf_share, over(shock_climate) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(g3, replace) title("Panel (c)")

lorenz estimate  normsfhu if normsfhu>0, over(shock_climate) graph(aspectratio(1)) 
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(g4, replace)title("Panel (d)")

graph combine g1 g2 g3 g4, iscale(0.5) graphregion(margin(l=80)) col(2)
grc1leg g1 g2 g3 g4,legendfrom(g1) position(3) 


*=================================================================================================================================================
*Figure 4: Lorenz Curves - Distribution of CHE by Age Group 
***============================================================================================================================================================== 
***============================================================================================================================================================== 
 
lorenz estimate  budget_share, over(age60) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(j1, replace) title("Panel (a)")
lorenz estimate  afs_share, over(age60) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(j2, replace) title("Panel (b)")

lorenz estimate  pnsf_share, over(age60) graph(aspectratio(1))
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(j3, replace) title("Panel (c)")

lorenz estimate  normsfhu if normsfhu>0, over(age60) graph(aspectratio(1)) 
lorenz graph, overlay aspectratio(1) xlabel(, grid) name(j4, replace)title("Panel (d)")

graph combine j1 j2 j3 j4, iscale(0.5) graphregion(margin(l=80)) col(2)
grc1leg j1 j2 j3 j4,legendfrom(j1) position(3) 


*=================================================================================================================================================
* Table 3 & 4: determinants and marginal effects 
***============================================================================================================================================================== 
***============================================================================================================================================================== 

xtprobit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year
outreg2 using myreg.doc, replace ctitle(probit che_budgetshare10)
estat ic
asdoc margins, dydx(*) replace 

xtprobit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year
outreg2 using myreg.doc, append ctitle(probit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append

xtprobit che_afsshare25 shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year
outreg2 using myreg.doc, append ctitle(probit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append

xtprobit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year
outreg2 using myreg.doc, append ctitle(probit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append 

xtprobit che_pnsfshare40 shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year 
outreg2 using myreg.doc, append ctitle(probit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

asdoc margins, dydx(*), append
xtprobit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year 
outreg2 using myreg.doc, append ctitle(probit che_normsfhu40)
estat ic
asdoc margins, dydx(*), append



*****************************************************************************************************************************************************************
*****************************************************************************************************************************************************************

****************************************************** SUPPLEMENTARY MATERIAL: ROBUSTNESS CHECKS   **************************************************************

*****************************************************************************************************************************************************************

*=================================================================================================================================================
*Table A1 & A2 Robust check random effects (Logit model )
***============================================================================================================================================================== 
***============================================================================================================================================================== 
 
xtlogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year ,re  
outreg2 using myreg.doc, replace ctitle(Logit che_budgetshare10)
estat ic
asdoc margins, dydx(*) , replace 

xtlogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year ,re 
outreg2 using myreg.doc, append ctitle(Logit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append

xtlogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year , re
outreg2 using myreg.doc, append ctitle(Logit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append

xtlogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year ,re 
outreg2 using myreg.doc, append ctitle(Logit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append 

xtlogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year ,re
outreg2 using myreg.doc, append ctitle(Logit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

xtlogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year ,re 
outreg2 using myreg.doc, append ctitle(Logit che_normsfhu40)
estat ic
asdoc margins, dydx(*), append


*=================================================================================================================================================
** Table A3 & A4: Robust check fixed effects (regional )
***============================================================================================================================================================== 
***============================================================================================================================================================== 

clogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (region)
outreg2 using myreg.doc, replace ctitle(Logit che_budgetshare10)
estat ic
asdoc margins, dydx(*) , replace 

clogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (region)
outreg2 using myreg.doc, append ctitle(Logit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append

clogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (region)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append

clogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (region)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append

clogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (region)
outreg2 using myreg.doc, append ctitle(Logit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

clogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (region)
outreg2 using myreg.doc, append ctitle(Logit che_normsfhu40)
estat ic
asdoc margins, dydx(*) , append


*=================================================================================================================================================
*Table A5 & A6: Robust Check fixed effexts (climate_risk_regions)
***============================================================================================================================================================== 
***==============================================================================================================================================================
clogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (climate_risk_regions)
outreg2 using myreg.doc, replace ctitle(Logit che_budgetshare10)
estat ic
asdoc margins, dydx(*) , replace 
clogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (climate_risk_regions)
outreg2 using myreg.doc, append ctitle(Logit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append
clogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (climate_risk_regions)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append
clogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (climate_risk_regions)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append

clogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (climate_risk_regions)
outreg2 using myreg.doc, append ctitle(Logit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

clogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec  , group (climate_risk_regions)
outreg2 using myreg.doc, append ctitle(Logit che_normsfhu40)
estat ic
asdoc margins, dydx(*) , append


*=================================================================================================================================================
*Table A7 & A8: Robust Check fixed effexts (Time)
***============================================================================================================================================================== 
***==============================================================================================================================================================
clogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (year)
outreg2 using myreg.doc, replace ctitle(Logit che_budgetshare10)
estat ic
asdoc margins, dydx(*) , replace 

clogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (year)
outreg2 using myreg.doc, append ctitle(Logit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append

clogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (year)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append

asdoc margins, dydx(*) , append
clogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (year)
outreg2 using myreg.doc, append ctitle(Logit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append

asdoc margins, dydx(*) , append
clogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec , group (year)
outreg2 using myreg.doc, append ctitle(Logit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

asdoc margins, dydx(*) , append
clogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec, group (year)
outreg2 using myreg.doc, append ctitle(Logit che_normsfhu40)
estat ic
asdoc margins, dydx(*) , append


*=================================================================================================================================================
*Table A9 & A10: Robust check fixed effects (households)
***============================================================================================================================================================== 
***============================================================================================================================================================== 

xtlogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec ,fe  
outreg2 using myreg.doc, replace ctitle(Logit che_budgetshare10)
estat ic
asdoc margins, dydx(*) , replace 
xtlogit che_budgetshare25 shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec ,fe 
outreg2 using myreg.doc, append ctitle(Logit che_budgetshare25)
estat ic
asdoc margins, dydx(*) , append
xtlogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec ,fe 
outreg2 using myreg.doc, append ctitle(Logit che_afsshare25)
estat ic
asdoc margins, dydx(*) , append
xtlogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec ,fe 
outreg2 using myreg.doc, append ctitle(Logit che_afsshare40)
estat ic
asdoc margins, dydx(*) , append 

xtlogit che_pnsfshare40 shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec,fe 
outreg2 using myreg.doc, append ctitle(Logit che_pnsfshare40)
estat ic
asdoc margins, dydx(*) , append

xtlogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec ,fe 
outreg2 using myreg.doc, append ctitle(Logit che_normsfhu40)
estat ic
asdoc margins, dydx(*), append


*=================================================================================================================================================
*Table A11: Hausman test
***============================================================================================================================================================== 
***============================================================================================================================================================== 
xtlogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_budgetshare10  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

xtlogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_budgetshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

xtlogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_afsshare25  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

xtlogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_afsshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

xtlogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_pnsfshare40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

xtlogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,fe
estimates store fe
xtlogit che_normsfhu40  shock_healthevent shock_climate ib5.wealth_quintile age60 education_father  marital_status_rec   hh_locality_rec year,re
estimates store re 
asdoc hausman fe re

***============================================================================================================================================================== 
***============================================================================================================================================================== 
***============================================================================================================================================================== 
***============================================================================================================================================================== 


*data exported for mapping in arcgis

use "SHOCKS and CHE full data 09182024.dta", clear


collapse (mean) budget_share afs_share pnsf_share normsfhu che_budgetshare10 che_budgetshare25 che_afsshare25 che_afsshare40 che_pnsfshare40 che_normsfhu40 shock_healthevent shock_climate, by (year region)

save "SHOCKS and CHE byregion data 09182024.dta",replace 

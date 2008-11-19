/*
Requirements:
lm_lad.tudla_std_prod_final@mktgcd_kcierpisz

*/

select * from lm_lad.tudla_std_prod_final@mktgcd_kcierpisz a

--- KCIERPISZ
drop table tudla_std_prod_final_bak;
rename tudla_std_prod_final to tudla_std_prod_final_bak;
create table tudla_std_prod_final as
select distinct duns_number, bi, crm, erp, app_ibm, app_jde, app_microsoft, app_oracle,
	   app_psft, app_sap, app_siebel, db2, oracle, ms_sql, site_id_number, confidence_code
from lm_lad.tudla_std_prod_final@mktgcd_kcierpisz a;
grant select on tudla_std_prod_final to tudla;

/*
select count(*), count(distinct a.duns_number) from tudla_std_prod_final a -- 33k 32k
select * from  tudla_std_prod_final a
where a.db2 + a.ms_sql + a.app_sap + a.app_microsoft + a.app_ibm + a.bi + a.crm + a.erp = 0
*/
/*
rename tudla_final to tudla_final_bak;
create table tudla_final as
select * from lm_lad.tudla_final@mktgcd_kcierpisz;
grant select on tudla_final to tudla;
rename tudla_std_prod to tudla_std_prod_bak;
create table tudla_std_prod as
select * from lm_lad.tudla_std_prod@mktgcd_kcierpisz;
grant select on tudla_std_prod to tudla;
*/
-- TUDLA
--drop table tudla_final;
/*
drop table tudla_final_bak;
rename tudla_final to tudla_final_bak;
create table tudla_final as
select * from kcierpisz.tudla_final;
grant select on tudla_final to public;
*/
/*
drop tudla_std_prod_bak;
rename tudla_std_prod to tudla_std_prod_bak;
create table tudla_std_prod as
select * from kcierpisz.tudla_std_prod;
grant select on tudla_std_prod to public;
*/

drop table tudla_std_prod_final_bak;
rename tudla_std_prod_final to tudla_std_prod_final_bak;
create table tudla_std_prod_final as
select * from kcierpisz.tudla_std_prod_final;
grant select on tudla_std_prod_final to public;


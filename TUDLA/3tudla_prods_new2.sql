select count(distinct a.site_id_number), 
count(distinct b.duns_number) from LM_LAD.TUDLA_STD_PROD a, lm_lad.tudla_final b
where a.app_sap = 1
and a.site_id_number = b.site_id_number

select * from lm_lad.tudla_std_prod

/*
create table tudla_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));

grant select on tudla_prods to tudla;		
*/

-- KCIERPISZ
drop table tudla_prods_new;
create table tudla_prods_new as
select * from (
select a.site_id_number, b.duns_number, b.confidence_code, 'IBM' product_code,'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_ibm = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'JDE' product_code,'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_jde = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'MICROSOFT' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_microsoft = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'ORACLE' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_oracle = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'PSFT' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_psft = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'SAP' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_sap = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'SIEBEL' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.app_siebel = 1
-- DMBS
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'DB2' product_code, 'DBMS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.db2 = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'ORACLE' product_code, 'DBMS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.oracle = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'MS_SQL' product_code, 'DBMS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.ms_sql = 1
--- MAIN APPLICATION
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'BI' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.bi = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'CRM' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.crm = 1
union all
select a.site_id_number, b.duns_number, b.confidence_code, 'ERP' product_code, 'APPLICATIONS' product_type
from tudla_std_prod a, tudla_final b
where a.site_id_number = b.site_id_number
and a.erp = 1
)
/*
select distinct a.product_code, a.product_type
from tudla_prods_new a
*/

drop table tudla_prods_leg_tmp;
create table tudla_prods_leg_tmp as
select a.*, (case when a.product_code = 'IBM' then 'IBM' 
				  when a.product_code = 'MS_SQL' then 'MICROSOFT' 
				  when a.product_code = 'MICROSOFT' then 'MICROSOFT'
				  when a.product_code = 'SIEBEL' then 'SIEBEL'
				  when a.product_code = 'SAP' then 'SAP'
				  when a.product_code = 'DB2' then 'IBM'
				  when a.product_code = 'ORACLE' then 'ORACLE'
				  when a.product_code = 'JDE' then 'JD EDWARDS'
				  when a.product_code = 'PSFT' then 'PEOPLESOFT'
				  end) as manufacturer,
(case when a.product_code = 'DB2' then 'DB2' 
	  when a.product_code = 'MS_SQL' then 'SQL SERVER' end) prod_model,
	(case when a.product_code = 'ERP' then 'WA2'
		  when a.product_code = 'CRM' then 'WC1' 
		  when a.product_code in ('JDE','SIEBEL','ORACLE','PSFT') then 'n/a' 
		  when a.product_code in ('IBM','SAP','MICROSOFT') and a.product_type = 'APPLICATIONS' then 'n/a' end) oracle_tier3,
	
	  (case when a.product_type = 'DBMS' and a.product_code <> 'ORACLE' then 'Y49' 
	  		when a.product_code = 'BI' then 'KR7' 
					  when a.product_code in ('JDE','SIEBEL','ORACLE','PSFT') then 'n/a' 
		  when a.product_code in ('IBM','SAP','MICROSOFT') and a.product_type = 'APPLICATIONS' then 'n/a'
			  end) oracle_tier4,
	 (case 		  when a.product_code in ('JDE','SIEBEL','ORACLE','PSFT') then 'n/a' 
		  when a.product_code in ('IBM','SAP','MICROSOFT') and a.product_type = 'APPLICATIONS' then 'n/a' end) oracle_tier5,
	 (case 		  when a.product_code in ('JDE','SIEBEL','ORACLE','PSFT') then 'n/a' 
		  when a.product_code in ('IBM','SAP','MICROSOFT') and a.product_type = 'APPLICATIONS' then 'n/a' end) oracle_tier6
from tudla_prods_new a;
grant select on tudla_prods_leg_tmp to public;

--TUDLA
drop table tudla_prods_leg_tmp_bak;
rename tudla_prods_leg_tmp to tudla_prods_leg_tmp_bak;
create table tudla_prods_leg_tmp as
select * from kcierpisz.tudla_prods_leg_tmp;

/*
select count(*), count(distinct a.duns_number) from tudla_prods_new a-- 35.556, 16.148
select a.confidence_code, count(*)  from tudla_prods_new a
group by a.confidence_code
order by count(*) desc

select distinct a.product_code, a.product_type from tudla_prods_new a
*/

--select * from tudla_prods_new
/*
select * from tudla_prods_leg_tmp a
where a.product_code = 'ORACLE'
and a.product_type = 'DBMS'

select a.* from tudla_prods_new a
where a.product_code = 'ORACLE'
*/

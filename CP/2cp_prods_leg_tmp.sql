--- COMPUTERPROFILE

drop table cp_prods;
create table cp_prods as
select 'CP' as vendor, s.ref_site, b.data_manufacturer manufacturer, b.data_model product_model, b.data_domain groupp
from computerprofile.data_site s, computerprofile.data_product b
where s.ref_site = b.ref_site;
/*
select a.groupp, count(*) from cp_prods a
group by a.groupp
*/
drop table cp_prods_leg_tmp;
create table cp_prods_leg_tmp as
select distinct a.manufacturer, a.product_model, a.groupp,
(case when a.groupp = 'CRM/SFA' then 'WC1' 
	  when a.groupp = 'ERP' then 'WA2' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
 	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier3, 
(case when a.groupp = 'APP-SERVER' then 'MA3'
	  when a.groupp = 'BI' then 'KR7' 
	  when a.groupp = 'CMS' then 'VR1' 
	  when a.groupp = 'DBMS' then 'Y49' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
   	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier4, 
(case when a.groupp = 'ACCOUNTING' then 'YC2' 
	  when a.groupp = 'FINANCE' then 'YC2' 
	  when a.groupp = 'HR' then 'YC5' 
	  when a.groupp = 'MANUFACTURER' then 'YC1' 
	  when a.groupp = 'MEDICAL' then 'YK7' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
 	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier5, 
(case when a.groupp = 'APPL/DEV' then 'Z07'
	  when a.groupp = 'DOC-MGMT' then 'ZJ1' 
	  when a.groupp = 'EAI' then 'ZX2' 
	  when a.groupp = 'GROUPWARE' then 'ZI8'
	  when a.groupp = 'PORTAL-MGMT' then 'ZX5'
	  when a.groupp = 'PROG-UTILITY' then 'Z07'
	  when a.groupp = 'RETAIL' then 'ZR1'
	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
	  when a.groupp = 'SUPPLY-CHAIN' then 'ZF2'
 	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'	  
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'WEB-SERVICES' then 'ZJ8'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier6
from cp_prods a
order by a.groupp

/*
select * from cp_prods_leg_tmp
*/

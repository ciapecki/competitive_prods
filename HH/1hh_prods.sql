-- KCIERPISZ
drop table hh_prods_old;
rename hh_prods to hh_prods_old;
create table hh_prods as
select 'HH' as vendor, s.siteid, b.manufacturer, b.product_model, c.groupp
from hartehanks.site_descriptions s, hartehanks.product b, hartehanks.product_specifications c
where s.siteid = b.siteid
and b.tabkey = c.tabkey;

--select count(*) from hh_prods_old

drop table hh_prods_leg_tmp;
create table hh_prods_leg_tmp as
select distinct a.manufacturer, a.product_model, a.groupp,
(case when a.groupp = 'CRM/SFA' then 'WC1' 
	  when a.groupp = 'ERP-UNSPEC' then 'WA2' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
 	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier3, 
(case when a.groupp = 'APP-SERVER' then 'MA3'
	  when a.groupp = 'BI' then 'KR7' 
	  when a.groupp = 'CONTENT-MGMT' then 'VR1' 
	  when a.groupp = 'DBMS' then 'Y49' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
   	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier4, 
(case when a.groupp = 'ACCOUNTING' then 'YC2' 
	  when a.groupp = 'BANK/FINANCE' then 'YC2' 
	  when a.groupp = 'HUMAN-RES' then 'YC5' 
	  when a.groupp = 'MANUFACTURER' then 'YC1' 
	  when a.groupp = 'MEDICAL' then 'YK7' 
 	  when a.groupp = 'SOFT-CONFIG' then 'n/a'
 	  when a.groupp = 'SVR-COMPUTNG' then 'n/a'
 	  when a.groupp = 'TEST-DEBUG' then 'n/a'
 	  when a.groupp = 'INSURANCE' then 'n/a'
	  end) oracle_tier5, 
(case when a.groupp = 'DEV-TOOL' then 'Z07'
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
from hh_prods a
order by a.groupp;



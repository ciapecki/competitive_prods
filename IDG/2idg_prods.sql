--KCIEPRISZ
-- IDG

drop table idg_prods_bak;
rename idg_prods to idg_prods_bak;

create table idg_prods as
select * from kcierpisz.idg_prods;

grant select on idg_prods to public;							

/*
call extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','COMPANYID','OPERATINGSYSTEM',',');
call extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','COMPANYID','DATABASESOFTWARE',',');
call extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','COMPANYID','DEVELOPMENTTOOLS',',');
call extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','COMPANYID','APPLICATIONS',',');
*/


update idg_prods a
set a.vendor_prod_type = 'DBMS' where a.vendor_prod_type = 'DATABASESOFTWARE';
commit;

--drop table idg_prods_names_bak;
--create table idg_prods_names_bak as select * from idg_prods_names;

drop table idg_prods_names;
create table idg_prods_names as
select a.site_id, a.vendor_prod_code,a.vendor_prod_type,
		b.APPLICATIONNAME prod_name, c.CategoryName category_name 
		from idg_prods a, tblapplications b, tblApplicationsCat c
where a.vendor_prod_code = b.ApplicationCode
and b.CategoryID = c.CATEGORYID
union all
select a.site_id, a.vendor_prod_code,a.vendor_prod_type,
		d.DatabaseName prod_name, e.CategoryName category_name 
		from idg_prods a, tblDatabase d, tblDatabasesCat e
where a.vendor_prod_code = d.DatabaseCode
and d.CategoryID = e.CategoryID
union all
select a.site_id, a.vendor_prod_code,a.vendor_prod_type,
		d.DevToolName prod_name, e.CategoryName category_name 
		from idg_prods a, TBLDEVELOPMENTTOOLS d, TBLDEVELOPMENTTOOLScat e
where a.vendor_prod_code = d.DevToolCode
and d.CategoryID = e.CategoryID
union all
select a.site_id, a.vendor_prod_code,a.vendor_prod_type,
		d.OpSystemName prod_name, e.CategoryName category_name 
		from idg_prods a, TBLOPERATINGSYSTEM d, TBLOPERATINGSYSTEMcat e
where a.vendor_prod_code = d.OpSystemCode
and d.CategoryID = e.CategoryID;

--select count(*) from idg_prods_names  -- 83459
grant select on idg_prods_names to public;

/*
create or replace view idg_prods_4_mapping as
select distinct a.vendor_prod_type, a.category_name,a.prod_name, '' prod_manufacturer, '' prod_model, '' oracle_tier6 
from idg_prods_names a
order by a.vendor_prod_type, a.category_name, a.prod_name;
grant select on idg_prods_4_mapping to public;

select * from idg_prods_4_mapping
*/




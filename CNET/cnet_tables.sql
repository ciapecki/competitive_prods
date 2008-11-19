----------- PRODS KCIERPISZ ---------------

--- KCIERPISZ ----

drop table cnet_prods_old;
rename cnet_prods to cnet_prods_old;
create table cnet_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));

grant select on cnet_prods to cnet;

call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','SERVER_OS',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','DESKTOP_OS',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','ACCOUNTING_FINANCE',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','CRM',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','DBMS',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','SECURITY_SOFTWARE',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','STORAGE_SOFTWARE',',');
call chrispack.extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','BUSINESS_INTELLIGENCE',',');

--CNET
drop table cnet_prods_old;
rename cnet_prods to cnet_prods_old;
create table cnet_prods as
select * from kcierpisz.cnet_prods;
grant select on cnet_prods to public;



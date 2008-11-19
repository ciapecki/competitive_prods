
create table cnet_apac_org_mis_info as select * from kcierpisz.cnet_apac_org_mis_info
create table cnet_apac_org_info as select * from sbarsin.cnet_apac_org_info

create table cnet_apac_org_info_d as
select a.*, b.dnb_duns_nbr, b.dnb_confidence_code from cnet_apac_org_info a, im202890_matchout b
where a.data_source_id = b.company_id


drop table cnet_apac_org_info_dist1;
create table cnet_apac_org_info_dist1 as
select rownum row_id, a.* from cnet_apac_org_info_d a;

select count(*) from cnet.cnet_apr08_im a -- 6237
select count(*) from cnet_apac_org_info a where a.key_no is not null -- 5395

create table im202890_matchout as select * from tbrauch.IM202890_matchout

select count(*) from tbrauch.IM202890_matchout a where a.dnb_duns_nbr is not null -- 5255



drop table cnet_apac_org_info_dist2;
create table cnet_apac_org_info_dist2 as
select a.data_source_id, count(*) cnt, min(row_id) row_id
from cnet_apac_org_info_dist1 a
group by a.data_source_id



select count(*) from cnet_apac_org_info_dist1 -- 6452
select count(distinct a.data_source_id) from cnet_apac_org_info_dist1 a -- 6237
select count(*) from cnet_apac_org_info_dist2 -- 6237

drop table cnet_apac_org_info_distinct;
create table cnet_apac_org_info_distinct as
select a.*
from cnet_apac_org_info_dist1 a, cnet_apac_org_info_dist2 b
where a.row_id = b.row_id

select count(*) from cnet_apac_org_info_distinct -- 6237
grant select on cnet_apac_org_info_distinct to public

drop table cnet_duns;
create table cnet_duns as
select a.data_source_id site_id, a.dnb_duns_nbr, a.dnb_confidence_code  from cnet_apac_org_info_dist1 a, cnet_apac_org_info_dist2 b
where a.row_id = b.row_id
and a.dnb_duns_nbr is not null

select count(*) from cnet_duns -- 5255

select * from cnet_duns
grant select on cnet_duns to public


----------- PRODS KCIERPISZ ---------------
--- CNET ----
drop table cnet_prods;
create table cnet_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));

grant select on cnet_prods to public;

select count(*) from cnet.cnet_apac_org_mis_info -- 12k
select count(distinct data_source_id) from cnet.cnet_apac_org_mis_info -- 6237
select distinct server_os, desktop_os,account_finance,crm,dbms from cnet.cnet_apac_org_mis_info

call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','SERVER_OS',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','DESKTOP_OS',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','ACCOUNTING_FINANCE',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','CRM',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','DBMS',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','SECURITY_SOFTWARE',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','STORAGE_SOFTWARE',',');
call extract_multiple_values('CNET.CNET_ORGS_PRODS','CNET_PRODS','COMPANY_ID','BUSINESS_INTELLIGENCE',',');


--------- end CNET_PRODS --------
/*
SERVER_OS,
DESKTOP_OS,
ACCOUNT_FINANCE,
CRM,
DBMS,
SECURITY_SOFTWARE,
STORAGE_SOFTWARE,
BUSINESS_INTELLIGENCE,
*/

select * from cnet_prods

create or replace view cnet_prods_to_map_vw as
select distinct a.vendor_prod_code, a.vendor_description, '' manuf, '' model, '' tier6  from cnet_prods a
order by a.vendor_description, a.vendor_prod_code

create table cnet_prods_to_map as 
	select a.vendor_prod_code, a.vendor_description, ' ' manuf, ' ' model, ' ' tier6 from cnet_prods_to_map_vw a where rownum < 1;

insert into cnet_prods_to_map 
	select * from cnet_prods_to_map_vw;
commit;

grant select on cnet_prods_to_map to public

select * from cnet_prods_to_map

select distinct a."GROUP" from hh_prods_map a
where upper(a.manuf) like '%APEX%'



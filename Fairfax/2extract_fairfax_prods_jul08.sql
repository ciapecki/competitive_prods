--KCIERPISZ

drop table fairfax_prods_old;
rename fairfax_prods to fairfax_prods_old;

create table fairfax_prods_tmp (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));

--grant select on fairfax_prods to public;

select * from fairfax_prods_tmp

call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','DBMS_SOFTWARE','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','FINANCIAL_SOFTWARE','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','EIS_SOFTWARE','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','ERP_SOFTWARE','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','CRM','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','HOST_SERVER_OS','/');
call chrispack.extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','PC_OS','/');

call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','DBMS_SOFTWARE','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','FINANCIAL_SOFTWARE','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','EIS_SOFTWARE','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','ERP_SOFTWARE','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','CRM','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','HOST_SERVER_OS','/');
call chrispack.extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','PC_OS','/');

drop table fairfax_prods;
create table fairfax_prods as 
select distinct a.site_id, a.vendor_prod_code, a.vendor_prod_type from fairfax_prods_tmp a;
grant select on fairfax_prods to fairfax;

--drop table fairfax_prod_descs_0508;
--create table fairfax_prod_descs as select * from fairfax_prod_descs2;

--FAIRFAX
drop table fairfax_prods_old;
rename fairfax_prods to fairfax_prods_old;
create table fairfax_prods as select * from kcierpisz.fairfax_prods;

/*
create table fairfax_prod_descs_0508 as select * from kcierpisz.fairfax_prod_descs_0508;
grant select on fairfax_prod_descs_0508 to public;
*/


----------------------
/*
create or replace view ff_prods_wo_definition as
select distinct 
            (case when a.vendor_description = 'CRM' then 'CRMS' 
             when a.vendor_description = 'DBMS_SOFTWARE' then 'DBMS Software'
             when a.vendor_description = 'EIS_SOFTWARE' then 'EIS Software'
             when a.vendor_description = 'ERP_SOFTWARE' then 'ERP Software'
             when a.vendor_description = 'FINANCIAL_SOFTWARE' then 'Financial Software'
             when a.vendor_description = 'HOST_SERVER_OS' then 'Host/Server OS'
             when a.vendor_description = 'PC_OS' then 'PC Operating System' end) "Type Desc",
             
             a.vendor_prod_code "SCode", '' "SCodeDesc" from fairfax_prods a
where (a.vendor_prod_code, a.vendor_description) not in (select b."SCode", b."Type Desc" from fairfax_prod_descs_0508 b)
order by "Type Desc", "SCode"

select * from fairfax_prod_descs_0508 a
where a."SCode" = 'CUS'

select * from fairfax_prod_descs_0508_org

select * from hh_prods_map
*/
/*
select (case when a.vendor_description = 'CRM' then 'CRMS' 
             when a.vendor_description = 'DBMS_SOFTWARE' then 'DBMS Software'
             when a.vendor_description = 'EIS_SOFTWARE' then 'EIS Software'
             when a.vendor_description = 'ERP_SOFTWARE' then 'ERP Software'
             when a.vendor_description = 'FINANCIAL_SOFTWARE' then 'Financial Software'
             when a.vendor_description = 'HOST_SERVER_OS' then 'Host/Server OS'
             when a.vendor_description = 'PC_OS' then 'PC Operating System' end) "Type Desc"
, a.vendor_prod_code "SCode", a.scodedesc "SCodeDesc"
from ff_prods_wo_definition a
*/

/*
select count(distinct a.mcode) from 
    (select * from fairfax.ff_mis_all
        union
     select * from fairfax.FAIRFAX_COMPANY_MIS_TAI_FULL) a, 
    ff_prods_wo_definition b
where a.crm = b."SCode" and b."Type Desc" = 'CRMS'
or a.dbms_software = b."SCode" and b."Type Desc" = 'DBMS Software'
or a.host_server_os = b."SCode" and b."Type Desc" = 'Host/Server OS'
or a.eis_software = b."SCode" and b."Type Desc" = 'EIS Software'
or a.financial_software = b."SCode" and b."Type Desc" = 'Financial Software'
or a.erp_software = b."SCode" and b."Type Desc" = 'ERP Software'
-- 2816
-- 2948 with TAI

select * from ff_prods_wo_definition a
select distinct a."Type Desc" from ff_prods_wo_definition a

--select * from fairfax_prods

create or replace view ff_prods_to_map_vw as
select distinct a.vendor_prod_code, a.vendor_description, '' manuf, ''  model, '' tier6, b."SCodeDesc"  from fairfax_prods a, fairfax_prod_descs_0508 b
where a.vendor_prod_code = b."SCode" (+) and a.vendor_description = b."Type Desc" (+)
order by a.vendor_description, a.vendor_prod_code

drop table ff_prods_to_map;
create table ff_prods_to_map as 
	select a.vendor_prod_code, a.vendor_description, ' ' manuf, ' ' model, ' ' tier6, a."SCodeDesc" from ff_prods_to_map_vw a where rownum < 1;

insert into ff_prods_to_map 
	select * from ff_prods_to_map_vw;
commit;

grant select on ff_prods_to_map to public;

select * from ff_prods_to_map

--select distinct a."Type Desc" from fairfax_prod_descs_0508 a
select * from fairfax.ff_mis_all a
where a.dbms_software in 
--select * from fairfax_prod_descs_0508 a
--where a."SCode" in 
('CHI',
'CIS',
'CUS',
'DAT'
)

select * from ff_prods_wo_definition a

*/

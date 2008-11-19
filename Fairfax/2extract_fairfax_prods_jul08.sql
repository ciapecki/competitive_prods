--KCIERPISZ
--FAIRFAX

create table fairfax_prods_bak as select * from fairfax_prods;
select count(*) from fairfax_prods_bak -- 113.869
select count(*) from fairfax_prods -- 124442
select count(*) from fairfax_prods_tmp --155.835

drop table fairfax_prods_old;
rename fairfax_prods to fairfax_prods_old;

--drop table fairfax_prods_tmp;
create table fairfax_prods_tmp (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));

--grant select on fairfax_prods to public;

select * from fairfax_prods_tmp

call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','DBMS_SOFTWARE','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','FINANCIAL_SOFTWARE','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','EIS_SOFTWARE','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','ERP_SOFTWARE','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','CRM','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','HOST_SERVER_OS','/');
call extract_multiple_values('fairfax.ff_mis_all','FAIRFAX_PRODS_TMP','MCODE','PC_OS','/');

call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','DBMS_SOFTWARE','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','FINANCIAL_SOFTWARE','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','EIS_SOFTWARE','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','ERP_SOFTWARE','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','CRM','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','HOST_SERVER_OS','/');
call extract_multiple_values('FAIRFAX.FAIRFAX_COMPANY_MIS_TAI_FULL','FAIRFAX_PRODS_TMP','MCODE','PC_OS','/');

drop table fairfax_prods;
create table fairfax_prods as 
select distinct a.site_id, a.vendor_prod_code, a.vendor_prod_type from fairfax_prods_tmp a;
grant select on fairfax_prods to public;

/*
select * from fairfax.ff_mis_all							
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.dbms_software is not null; --12372
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'DBMS_SOFTWARE'; -- 12.372
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.financial_software is not null; --12706
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'FINANCIAL_SOFTWARE'; -- 12.706
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.eis_software is not null; --4089
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'EIS_SOFTWARE'; -- 4089
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.erp_software is not null; --6687
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'ERP_SOFTWARE'; -- 6687
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.crm is not null; --3610
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'CRM'; --3610
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.host_server_os is not null; --13.693
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'HOST_SERVER_OS'; --13.693
select count(distinct a.mcode) from fairfax.ff_mis_all a where a.pc_os is not null; --13.818
select count(distinct a.site_id) from fairfax_prods a where a.vendor_prod_type = 'PC_OS'; --13.818

select distinct a.description from fairfax_prod_descs a

select * from all_tables a
where a.owner in ('KCIERPISZ','FAIRFAX')
and a.table_name like '%MAP%'

select * from hh_prods_map a
*/
--select distinct a.vendor_description from fairfax_prods a
/*
CRM
DBMS_SOFTWARE
EIS_SOFTWARE
ERP_SOFTWARE
FINANCIAL_SOFTWARE
HOST_SERVER_OS
PC_OS
*/
/*
select distinct a.description from fairfax_2_ora a
select distinct a.vendor_prod_type from fairfax_prods a


select distinct a.description from fairfax_2_ora a

update fairfax_2_ora a
set description = 'CRM' where a.description = 'CRMS';
commit;
update fairfax_2_ora a
set description = 'DBMS_SOFTWARE' where a.description = 'DBMS Software';
commit;
update fairfax_2_ora a
set description = 'EIS_SOFTWARE' where a.description = 'EIS Software';
commit;
update fairfax_2_ora a
set description = 'ERP_SOFTWARE' where a.description = 'ERP Software';
commit;
update fairfax_2_ora a
set description = 'FINANCIAL_SOFTWARE' where a.description = 'Financial Software';
commit;
update fairfax_2_ora a
set description = 'HOST_SERVER_OS' where a.description = 'Host/Server OS';
commit;
update fairfax_2_ora a
set description = 'PC_OS' where a.description = 'PC Operating System';
commit;
*/

select * from fairfax_2_ora
-- chech if all descriptions mapped
select distinct a.vendor_description, b.description from fairfax_prods a, fairfax_2_ora b
where a.vendor_description = b.description (+)

select a.*, b.* from fairfax_prods a, fairfax_2_ora b
where a.vendor_prod_code = b.scode (+)
and a.vendor_description = b.description (+)

select count(*) from fairfax_prods -- 141.817

select distinct model, "GROUP", description from hh_prods_map
select * from hh_prods_map a where a.model = 'VISION' and a."GROUP" = 'BI'


select distinct a.vendor_prod_code, a.vendor_description from fairfax_prods a
group by a.vendor_description, a.vendor_prod_code

select * from fairfax_prods
select distinct * from fairfax_2_ora a where a.description in ('CRM',
'DBMS_SOFTWARE',
'EIS_SOFTWARE',
'ERP_SOFTWARE',
'FINANCIAL_SOFTWARE',
'HOST_SERVER_OS',
'PC_OS')

select distinct a.vendor_prod_code, a.vendor_description, b.* from fairfax_prods a, fairfax_2_ora b
where a.vendor_prod_code = b.scode (+)
and a.vendor_description = b.description (+)


select * from hh_prods_map a
where a.manuf = 'PSIPENTA'

create table fairfax_prod_descs2 as 
select * from fairfax_prod_descs;

--drop table fairfax_prod_descs_0508;
--create table fairfax_prod_descs as select * from fairfax_prod_descs2;

create table fairfax_prod_descs_0508 as select * from kcierpisz.fairfax_prod_descs_0508;

select count(*) from fairfax_prod_descs_0508
select * from fairfax_prod_descs_0508
create table fairfax_prod_descs_0508_org as select * from fairfax_prod_descs_0508;

/*
update fairfax_prod_descs_0508 a
set "Type Desc" = 'CRM' where a."Type Desc" = 'CRMS';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'DBMS_SOFTWARE' where a."Type Desc" = 'DBMS Software';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'EIS_SOFTWARE' where a."Type Desc" = 'EIS Software';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'ERP_SOFTWARE' where a."Type Desc" = 'ERP Software';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'FINANCIAL_SOFTWARE' where a."Type Desc" = 'Financial Software';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'HOST_SERVER_OS' where a."Type Desc" = 'Host/Server OS';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'PC_OS' where a."Type Desc" = 'PC Operating System';
commit;
update fairfax_prod_descs_0508 a
set "Type Desc" = 'PC_OS' where a."Type Desc" = 'PC OS';
commit;
*/
--select distinct "Type Desc" from fairfax_prod_descs_0508

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



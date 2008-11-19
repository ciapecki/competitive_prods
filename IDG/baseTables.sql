create table tblCompanies as
select * from kcierpisz.tblcompanies;
grant select on tblCompanies to public;

create table tblApplications as
select * from kcierpisz.tblApplications;
grant select on tblApplications to public;

grant select on tblApplicationsCat to public

select * from user_tables

select * from tblcompanies

create table tblcomp1 as
select * from tblcompanies a where rownum < 10

select * from tblcomp1

--drop table idg_prods;
create table idg_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));
							
call extract_multiple_values('TBLCOMPANIES','IDG_PRODS','"CompanyID"','"Applications"',',');
call extract_multiple_values('TBLCOMPANIES','IDG_PRODS','"CompanyID"','"DatabaseSoftware"',',');
call extract_multiple_values('TBLCOMPANIES','IDG_PRODS','"CompanyID"','"OperatingSystem"',',');
call extract_multiple_values('TBLCOMPANIES','IDG_PRODS','"CompanyID"','"DevelopmentTools"',',');

select * from idg_prods a, tblapplications b, tblApplicationsCat c, tblDatabase d, tblDatabasesCat e
where a.vendor_prod_code = b."ApplicationCode" (+)
and b."CategoryID" = c."CategoryID" (+)
and a.vendor_prod_code = d."DatabaseCode" (+)
and d."CategoryID" = e."CategoryID" (+)
and a.site_id = 1003


Lotus Notes; SunSystems; Lotus Notes/Domino Knowledge Management; Lotus Notes/Domino Messaging System; OpenOffice
A162, A182, A338, A217, A255, A273, A280,

select a."CompanyID", a."Applications" from tblCompanies a
where a."CompanyID" = 1918

select a.companyid, a.applications from sbarsin.idg_orgs_may08 a
where a.companyid = 1918

select * from idg_prods a
where a.vendor_prod_type like '%Oper%'

select * from user_tables

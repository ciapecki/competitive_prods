/* grant select on tblApplicationsCat to public
*/

select * from idg.tblcompanies

--KCIERPISZ
drop table idg_prods;
create table idg_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));
							
call chrispack.extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','CompanyID','APPLICATIONS',',');
call chrispack.extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','CompanyID','DATABASESOFTWARE',',');
call chrispack.extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','CompanyID','OPERATINGSYSTEM',',');
call chrispack.extract_multiple_values('IDG.TBLCOMPANIES','IDG_PRODS','CompanyID','DEVELOPMENTTOOLS',',');

grant select on idg_prods to idg;

--IDG
drop table idg_prods_old;
rename idg_prods to idg_prods_old;
create table idg_prods as select * from kcierpisz.idg_prods;
grant select on idg_prods to public;							
/*
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
*/

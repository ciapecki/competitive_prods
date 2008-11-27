select distinct vendor from competitive_prods

--check
/*
select count(distinct a.duns)
from competitive_prods a
where a.vendor = 'TUDLA' -- 13.859

select count(distinct a.duns)
from competitive_prods a,
tudla.tudla_std_prod_final b
where a.duns = b.duns_number 
and a.vendor = 'TUDLA'  -- 13.859

select count(distinct a.duns)
from competitive_prods a
where a.vendor = 'FAIRFAX' -- 10.880

select count(distinct a.duns)
from competitive_prods a,fairfax.ff_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'FAIRFAX'  -- 10.880

select count(distinct a.duns)
from competitive_prods a
where a.vendor = 'IDG' -- 3.362

select count(distinct a.duns)
from competitive_prods a,idg.idg_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'IDG'  -- 3.362

select count(distinct a.duns)
from competitive_prods a
where a.vendor = 'CNET' -- 4.410

select count(distinct a.duns)
from competitive_prods a,cnet.cnet_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'CNET'  -- 4.410
*/

select count(distinct a.duns)
from competitive_prods a
where a.vendor = 'CP' -- 41.327

select count(distinct a.duns)
from competitive_prods a,computerprofile.cp_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'CP'  -- 41.327

select distinct prod_manufacturer from competitive_prods a where a.vendor = 'TUDLA'
select distinct prod_model from competitive_prods a where a.vendor = 'TUDLA'

select distinct prod_manufacturer from competitive_prods a where a.vendor = 'FAIRFAX'
select distinct prod_model from competitive_prods a where a.vendor = 'FAIRFAX'

select distinct prod_manufacturer from competitive_prods a where a.vendor = 'IDG'
select distinct prod_model from competitive_prods a where a.vendor = 'IDG'

select distinct prod_manufacturer from competitive_prods a where a.vendor = 'CNET'
select distinct prod_model from competitive_prods a where a.vendor = 'CNET'

select prod_manufacturer, count(*) from competitive_prods a where a.vendor = 'CP'
group by a.prod_manufacturer order by count(*) desc
select prod_model, count(*) from competitive_prods a where a.vendor = 'CP'
group by a.prod_model order by count(*) desc

select prod_manufacturer, count(*) from competitive_prods a where a.vendor = 'HH'
group by a.prod_manufacturer order by count(*) desc
select prod_model, count(*) from competitive_prods a where a.vendor = 'HH'
group by a.prod_model order by count(*) desc

drop table twiki_tmp;
create table twiki_tmp as
select a.duns, a.vendor, upper(b.country) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL AB' then 1 else 0 end) MYSQL
from competitive_prods a, tudla.tudla_std_prod_final b
where a.duns = b.duns_number 
and a.vendor = 'TUDLA'
group by a.duns, a.vendor, upper(b.country)
union
select a.duns, a.vendor, upper(b.dnb_co_country_name) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL-SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL AB' then 1 else 0 end) MYSQL
from competitive_prods a, fairfax.ff_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'FAIRFAX'
group by a.duns, a.vendor, upper(b.dnb_co_country_name)
union
select a.duns, a.vendor, upper(b.dnb_co_country_name) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL-SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL AB' then 1 else 0 end) MYSQL
from competitive_prods a, idg.idg_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'IDG'
group by a.duns, a.vendor, upper(b.dnb_co_country_name)
union
select a.duns, a.vendor, upper(b.dnb_co_country_name) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL-SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL AB' then 1 else 0 end) MYSQL
from competitive_prods a, cnet.cnet_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor = 'CNET'
group by a.duns, a.vendor, upper(b.dnb_co_country_name)
union
select a.duns, 'CP' vendor, upper(b.dnb_co_country_name) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL-SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL AB' then 1 else 0 end) MYSQL
from competitive_prods a, computerprofile.cp_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor in ('CP','CP,HH')
group by a.duns, a.vendor, upper(b.dnb_co_country_name)
union
select a.duns, 'HH' vendor, upper(b.dnb_co_country_name) country,
max(case when a.prod_manufacturer = 'IBM' then 1 else 0 end) IBM,
max(case when a.prod_manufacturer = 'MICROSOFT' then 1 else 0 end) MICROSOFT,
max(case when a.prod_manufacturer = 'SAP' then 1 else 0 end) SAP,
max(case when a.prod_model = 'DB2' then 1 else 0 end) IBM_DB2,
max(case when a.prod_model = 'SQL-SERVER' then 1 else 0 end) MS_SQL_SERVER,
max(case when a.prod_manufacturer = 'MYSQL-AB' then 1 else 0 end) MYSQL
from competitive_prods a, kcierpisz.hh_im_matchout b
where a.duns = b.dnb_duns_nbr
and a.vendor in ('HH','CP,HH')
group by a.duns, a.vendor, upper(b.dnb_co_country_name)
;

select * from twiki_tmp

ENGLAND -- United Kingdom
MÉXICO -- Mexico
NORTHERN IRELAND -- Ireland
PANAMÁ -- Panama
PERÚ -- Peru
SCOTLAND -- United Kingdom
TRINIDAD & TOBAGO -- Trinidad and Tobago
USA -- United States
VIRGIN ISLANDS US -- United States Virgin Islands
WALES -- United Kingdom

alter table twiki_tmp add (gcd_country varchar2(100));
update twiki_tmp a set gcd_country = 'UNITED KINGDOM' where a.country = 'ENGLAND';
update twiki_tmp a set gcd_country = 'MEXICO' where a.country like 'M%XICO';
update twiki_tmp a set gcd_country = 'PERU' where a.country like 'PER%';
update twiki_tmp a set gcd_country = 'IRELAND' where a.country like 'NORTHERN IRELAND';
update twiki_tmp a set gcd_country = 'PANAMA' where a.country like 'PANAM%';
update twiki_tmp a set gcd_country = 'UNITED KINGDOM' where a.country = 'SCOTLAND';
update twiki_tmp a set gcd_country = 'TRINIDAD AND TOBAGO' where a.country = 'TRINIDAD & TOBAGO';
update twiki_tmp a set gcd_country = 'UNITED STATES' where a.country = 'USA';
update twiki_tmp a set gcd_country = 'UNITED STATES VIRGIN ISLANDS' where a.country = 'VIRGIN ISLANDS US';
update twiki_tmp a set gcd_country = 'UNITED KINGDOM' where a.country = 'WALES';
commit;

update twiki_tmp a set gcd_country = (select upper(name) from gcd_dw.gcd_countries b
										where upper(b.name) = a.country)
					where gcd_country is null;
commit;

select count(*) from twiki_tmp; -- 94.643

drop table twiki_tmp_region;
create table twiki_tmp_region nologging as
select a.*, c.name sub_region_name, 
(case when d.name is not null then d.name 
	  when c.name is not null then c.name end) region_name
from twiki_tmp a, gcd_dw.gcd_countries b, gcd_dw.gcd_regions c, gcd_dw.gcd_regions d
where upper(a.gcd_country) = upper(b.name)
and b.region_id = c.region_id
and c.parent_region_id = d.region_id (+)
;

select count(*) from twiki_tmp_region; -- 94.643

select * from twiki_tmp_region

create or replace view twiki_vw as
select a.vendor, initcap(a.country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp a, gcd_dw.gcd_countries b
where initcap(a.country) = b.name
group by grouping sets ((a.vendor, a.country), a.vendor)
order by a.vendor, count(distinct a.duns) desc, a.country


create or replace view twiki_vw_reg1 as
select a.sub_region_name, a.vendor, initcap(a.gcd_country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp_region a, gcd_dw.gcd_countries b
where initcap(a.country) = b.name
group by grouping sets ((a.sub_region_name, a.vendor, a.gcd_country), (a.sub_region_name,a.vendor), a.sub_region_name)
order by a.sub_region_name, nvl(a.vendor,'AAA'), count(distinct a.duns) desc, nvl(a.gcd_country,'AAA');

create or replace view twiki_vw_reg2 as
select a.vendor, a.sub_region_name, initcap(a.gcd_country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp_region a, gcd_dw.gcd_countries b
where initcap(a.country) = b.name
group by grouping sets ((a.vendor, a.sub_region_name, a.gcd_country), (a.vendor,a.sub_region_name), a.vendor)
order by nvl(a.vendor,'AAA'), nvl(a.sub_region_name,'AAA'), count(distinct a.duns) desc, nvl(a.gcd_country,'AAA');

create or replace view twiki_vw_reg1_1 as
select a.region_name, a.sub_region_name, a.vendor, initcap(a.gcd_country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp_region a, gcd_dw.gcd_countries b
where initcap(a.country) = b.name
group by grouping sets ((a.region_name, a.sub_region_name, a.vendor, a.gcd_country), (a.region_name, a.sub_region_name, a.vendor), (a.region_name,a.sub_region_name), a.region_name)
order by nvl(a.region_name,'AAA'),nvl(a.sub_region_name,'AAA'), nvl(a.vendor,'AAA'), count(distinct a.duns) desc, nvl(a.gcd_country,'AAA');

create or replace view twiki_vw_reg2_1 as
select a.vendor, a.region_name, a.sub_region_name, initcap(a.gcd_country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp_region a, gcd_dw.gcd_countries b
where initcap(a.country) = b.name
group by grouping sets ((a.vendor, a.region_name, a.sub_region_name, a.gcd_country), (a.vendor, a.region_name, a.sub_region_name), (a.vendor, a.region_name), a.vendor)
order by nvl(a.vendor,'AAA'), nvl(a.region_name,'AAA'), nvl(a.sub_region_name,'AAA'), count(distinct a.duns) desc, nvl(a.gcd_country,'AAA');


select * from twiki_vw_reg1
select * from twiki_vw_reg2
select * from twiki_vw_reg1_1
select * from twiki_vw_reg2_1

select distinct a.country from twiki_tmp a
minus
select distinct a.country from twiki_tmp a, gcd_dw.gcd_countries b
where a.country = upper(b.name)

select * from gcd_dw.gcd_countries a
where upper(a.name) like '%WALES%'


select * from twiki_vw

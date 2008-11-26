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


create or replace view twiki_vw as
select a.vendor, initcap(a.country) country, 
count(distinct a.duns) companies, 
sum(ibm) ibm_total, sum(a.ibm_db2) ibm_db2, 
sum(a.microsoft) microsoft_total, sum(a.ms_sql_server) microsoft_sql_server , sum(a.sap) sap_total
from twiki_tmp a
group by grouping sets ((a.vendor, a.country), a.vendor)
order by a.vendor, count(distinct a.duns) desc

select a.country, count(distinct a.duns) no_companies, 
sum(ibm), sum(a.ibm_db2), 
sum(a.microsoft), sum(a.ms_sql_server) , sum(a.sap)
from twiki_tmp a
where a.country = 'BELGIUM'
group by grouping sets (a.country)

select a.vendor, count(distinct a.duns) no_companies, 
sum(ibm), sum(a.ibm_db2), 
sum(a.microsoft), sum(a.ms_sql_server) , sum(a.sap)
from twiki_tmp a
group by grouping sets (a.vendor,())


select count(distinct a.duns) from competitive_prods a
where a.vendor = 'CP,HH'


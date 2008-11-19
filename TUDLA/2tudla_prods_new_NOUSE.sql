select * from tudla.tudla_full


-- KCIERPISZ
drop table tudla_prods;
create table tudla_prods (site_id varchar2(100),
							vendor_prod_code varchar2(100),
							vendor_prod_type varchar2(100));
							
							
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','MAIN_OPERATING_SYSTEM',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','OTHER_OPERATING_SYSTEM_',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_1',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_BRAND_1',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_2',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_BRAND_2',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_3',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','PRIMARY_APPLICATION_BRAND_3',',');
call chrispack.extract_multiple_values('TUDLA.TUDLA_FULL','TUDLA_PRODS','SITE_ID_NUMBER','DB_BRAND_',',');

delete from tudla_prods a
where upper(a.vendor_prod_code) in ('N/A','(Outsourcing)');
commit;


/*
select * from tudla_prods a

select distinct a.vendor_prod_code, a.vendor_prod_type from tudla_prods a
order by a.vendor_prod_type, a.vendor_prod_code

select distinct a.vendor_prod_code from tudla_prods a


select a.db_brand_ from tudla.tudla_full a
where a.db_brand_ like '%/%'
*/

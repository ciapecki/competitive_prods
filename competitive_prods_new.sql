--create table competitive_prods_tmp_bak as select * from competitive_prods_tmp;
--select count(*) from competitive_prods_tmp_bak --804651
--select count(*) from competitive_prods_tmp --804651

/*
-- REQUIREMENTS:
server: JUPITER
kcierpisz.hh_prods,
kcierpisz.hh_prods_leg,
computerprofile.cp_prods_leg,
fairfax.fairfax_prods,
fairfax.fairfax_prods_leg,
kcierpisz.cnet_prods, 
cnet.cnet_prods_leg,
idg.idg_prods_names, 
idg.idg_prods_leg,
tudla.tudla_prods_leg_tmp, 
tudla.tudla_prods_leg,

fairfax.ff_4_im_0608_matchout,
idg.idg_4_im_0608_matchout,
cnet.im202890_matchout,
computerprofile.cp_im_matchout,
kcierpisz.hh_im_matchout
*/

drop table competitive_prods_tmp_old;
rename competitive_prods_tmp to competitive_prods_tmp_old;
create table competitive_prods_tmp
(--duns varchar2(9),
 vendor_site_id varchar2(30),  -- added 26.06.08
 vendor_prod_code varchar2(40),
 vendor_prod_type varchar2(40),
 vendor_prod_description varchar2(100),
 prod_manufacturer varchar2(100),
 prod_model varchar2(100),
 oracle_tier3 varchar2(3),
 oracle_tier4 varchar2(3),
 oracle_tier5 varchar2(3),
 oracle_tier6 varchar2(3),
 vendor varchar2(20)) nologging;
 
 grant select on competitive_prods_tmp to public;
 
/* 
 select * from computerprofile.cp_prods_leg a
 where upper(a.product_model) like 'INFORMIX%'

select * from competitive_prods_tmp
 */
  
 

-- HH
 insert into competitive_prods_tmp nologging
 select --'' duns_number,  
        a.siteid, '' prod_code, a.groupp, '' prod_description, 
 		b.manufacturer,b.product_model product_model, b.oracle_tier3, b.oracle_tier4, b.oracle_tier5, b.oracle_tier6, a.vendor
		 from hh_prods a, hh_prods_leg b
		 where --a.duns_number is not null
		 a.manufacturer = b.manufacturer
		 and a.product_model = b.product_model
		 and a.groupp = b.groupp
		 and a.manufacturer not in ('ORACLE','HYPERION','SIEBEL','PEOPLESOFT')
		 ;
 commit;

-- CP
--	select * from cp_im_matchout
--	delete from competitive_prods_tmp a where a.vendor = 'CP'; commit;

 insert into competitive_prods_tmp nologging
 select --'' ref_duns, 
        b.ref_site, '' prod_code, a.data_domain, '' prod_description, nvl(c.manufacturer, a.data_manufacturer) data_manufacturer, 
        nvl(c.product_model,a.data_model) data_model, 
 c.oracle_tier3, c.oracle_tier4, c.oracle_tier5, c.oracle_tier6, 'CP' 
 from computerprofile.data_product a, computerprofile.data_site b, computerprofile.cp_prods_leg c
 where a.ref_site = b.ref_site
 --and b.ref_duns is not null
 and a.ref_module in ('PRG','OPR')
-- and a.data_manufacturer = c.manufacturer
 and replace(a.data_manufacturer,'INFORMIX','IBM') = c.manufacturer
 and a.data_model = c.product_model
 and a.data_domain = c.groupp
  and a.data_manufacturer not in ('ORACLE','HYPERION','SIEBEL','PEOPLESOFT')
 ;
 commit;

--FAIRFAX
	insert into competitive_prods_tmp nologging
	select --'' dnb_duns_nbr, 
        a.mcode, a.vendor_prod_code, a.vendor_prod_type vendor_description, 
        b."vendor_SCodeDesc" prod_description, 
		b.manufacturer,b.model product_model, 
        b.oracle_tier3, b.oracle_tier4, b.oracle_tier5, b.oracle_tier6, 'FAIRFAX' vendor
		from fairfax.fairfax_prods a, fairfax.fairfax_prods_leg b
		where --a.dnb_duns_nbr is not null
		a.vendor_prod_code = b.vendor_prod_code
		and a.vendor_prod_type = b.vendor_description
		and a.vendor_prod_code not in ('ORA','HYP','SIE','PEO')
        ;	
	commit;

--CNET

--    select * from cnet_prods
--    select * from cnet.cnet_apac_org_info_distinct b
    
	insert into competitive_prods_tmp nologging
	select --'' dnb_duns_nbr, 
    a.site_id, a.vendor_prod_code, a.vendor_prod_type vendor_description, 
            '' prod_description, 
		  b.manufacturer manufacturer, b.model product_model, 
          b.oracle_tier3, b.oracle_tier4, b.oracle_tier5, b.oracle_tier6,
          'CNET' 
          from cnet_prods a, cnet.cnet_prods_leg b
	where a.vendor_prod_code = b.vendor_prod_code
	and a.vendor_prod_type  = b.vendor_description   
	and upper(a.vendor_prod_code) not in ('ORACLE','HYPERION','SIEBEL','PEOPLESOFT')
    ;
	commit;

--IDG
--select * from competitive_prods_tmp
/*select count(*) from idg.idg_prods_names -- 83.459
select count(*) from idg.idg_prods -- 83.459
*/
    insert into competitive_prods_tmp nologging
    select --'' duns_number, 
    a.site_id, b.prod_name vendor_prod_code, b.vendor_prod_type,
            b.category_name prod_description,
            b.manufacturer, b.model,
            b.oracle_tier3, b.oracle_tier4, b.oracle_tier5, b.oracle_tier6,
            'IDG'
--            select count(*)
            from idg.idg_prods_names a, idg.idg_prods_leg b
            where a.vendor_prod_type = b.vendor_prod_type
            and a.prod_name = b.prod_name
            and a.category_name = b.category_name
            and (
            	upper(a.vendor_prod_code) not like 'PEOPLESOFT%'
            	or upper(a.vendor_prod_code) not like 'ORACLE%'
            	or upper(a.vendor_prod_code) not like 'HYPERION%'            	
            	or upper(a.vendor_prod_code) not like 'SIEBEL%'            	
            );
            commit;

/*
select * from competitive_prods_tmp a
where a.prod_model = 'MY IS-A'

select distinct a.vendor_prod_type from competitive_prods_tmp a
select distinct a.prod_manfuacturer from competitive_prods_tmp a
select distinct a.prod_model from competitive_prods_tmp a
*/

-- TUDLA
insert into competitive_prods_tmp nologging
    select --'' duns_number, 
    a.site_id_number site_id, b.prod_name vendor_prod_code, b.vendor_prod_type,
            b.category_name prod_description,
            b.manufacturer, b.model,
            b.oracle_tier3, b.oracle_tier4, b.oracle_tier5, b.oracle_tier6,
            'TUDLA'
from tudla.tudla_prods_leg_tmp a, tudla.tudla_prods_leg b 
where a.product_code = b.prod_name
and a.product_type = b.vendor_prod_type
and b.prod_name not in ('ORACLE','SIEBEL','HYPERION','PEOPLESOFT')
;
commit;

/*
select a.vendor, count(*) no_of_recs, count(distinct a.vendor_site_id) no_of_sites 
from competitive_prods_tmp a
group by a.vendor;
*/

-------------------------------- competitive_prods_tmp --------------  end  --------------------

----- creaete competitive_prods with DUNS --------

--select * from competitive_prods_tmp

drop table competitive_prods_tmp_duns;
create table competitive_prods_tmp_duns nologging as
select b.dnb_duns_nbr im_duns, a.*
from competitive_prods_tmp a, fairfax.ff_4_im_0608_matchout b
where a.vendor_site_id = b.company_id
and a.vendor = 'FAIRFAX'
and b.dnb_confidence_code >= 8
union all
select b.dnb_duns_nbr im_duns, a.*
from competitive_prods_tmp a, idg.idg_4_im_0608_matchout b
where a.vendor_site_id = b.company_id
and a.vendor = 'IDG'
and b.dnb_confidence_code >= 8
union all
select b.duns_number, a.*
from competitive_prods_tmp a, tudla.tudla_prods_leg_tmp b
where a.vendor_site_id = b.site_id_number
and a.vendor = 'TUDLA'
and b.confidence_code >= 8
union all
select b.dnb_duns_nbr im_duns, a.*
from competitive_prods_tmp a, cnet.im202890_matchout b
where a.vendor_site_id = b.company_id
and a.vendor = 'CNET'
and b.dnb_confidence_code >= 8
union all
select b.dnb_duns_nbr im_duns, a.*
from competitive_prods_tmp a, computerprofile.cp_im_matchout b
where a.vendor_site_id = b.company_id
and a.vendor = 'CP'
and b.dnb_confidence_code >= 8
union all
select b.dnb_duns_nbr im_duns, a.*
from competitive_prods_tmp a, kcierpisz.hh_im_matchout b
where a.vendor_site_id = b.company_id
and a.vendor = 'HH'
and b.dnb_confidence_code >= 8;

--select count(*) from  competitive_prods_tmp_duns -- 634.506 -- site_ids + duns numbers
grant select on competitive_prods_tmp_duns to public;

--- FINAL competitive_prods

--select count(*) FROM COMPETITIVE_PRODS_BAK; --697.491
--select count(*) FROM COMPETITIVE_PRODS; --707.081 -- 673.483

drop table competitive_prods_bak;
rename competitive_prods to competitive_prods_bak;

create table competitive_prods as
select a.im_duns duns, a.prod_manufacturer, a.prod_model,
a.oracle_tier3, a.oracle_tier4, a.oracle_tier5, a.oracle_tier6,
to_row(distinct a.vendor) vendor, a.vendor_prod_code, a.vendor_prod_type, a.vendor_prod_description
from competitive_prods_tmp_duns a
where nvl(a.im_duns,' ') <> ' '
group by a.im_duns, a.prod_manufacturer, a.prod_model, a.oracle_tier3, a.oracle_tier4, 
        a.oracle_tier5, a.oracle_tier6, a.vendor_prod_code, a.vendor_prod_type, a.vendor_prod_description;

grant select on competitive_prods to public;

drop index bt_competitive_prods_duns;
drop index bm_competitive_prods_manuf;
drop index bm_competitive_prods_model;
drop index bm_competitive_prods_t3;
drop index bm_competitive_prods_t4;
drop index bm_competitive_prods_t5;
drop index bm_competitive_prods_t6;
drop index bm_competitive_prods_vendor;

create index bt_competitive_prods_duns on competitive_prods (duns);
create bitmap index bm_competitive_prods_manuf on competitive_prods(prod_manufacturer);
create bitmap index bm_competitive_prods_model on competitive_prods(prod_model);
create bitmap index bm_competitive_prods_t3 on competitive_prods(oracle_tier3);
create bitmap index bm_competitive_prods_t4 on competitive_prods(oracle_tier4);
create bitmap index bm_competitive_prods_t5 on competitive_prods(oracle_tier5);
create bitmap index bm_competitive_prods_t6 on competitive_prods(oracle_tier6);
create bitmap index bm_competitive_prods_vendor on competitive_prods(vendor);

--create index bt_compet_prods_duns on competitive_prods (duns);
-- END competitive prods -------------------



/*
select a.* from competitive_prods a where a.vendor = 'CP'
and a.prod_model = 'DB2'

select a.vendor, count(*), count(distinct a.duns) from competitive_prods a
group by a.vendor

select count(*) from competitive_prods
*/

--- with org_ids -----

drop table competitive_prods_org_bak;
rename competitive_prods_org to competitive_prods_org_bak;
create table competitive_prods_org nologging as
select a.*, replace(b.org_id,99999999,null) org_id from competitive_prods a, dnb.full_dnb_wb_all b
where a.duns = b.duns_number;

grant select on competitive_prods_org to public;
----------------------

-- with org_ids
drop index bt_competitive_prods_o_duns;
drop index bm_competitive_prods_o_manuf;
drop index bm_competitive_prods_o_model;
drop index bm_competitive_prods_o_t3;
drop index bm_competitive_prods_o_t4;
drop index bm_competitive_prods_o_t5;
drop index bm_competitive_prods_o_t6;
drop index bm_competitive_prods_o_vendor;
drop index bt_competitive_prods_o_org;

create index bt_competitive_prods_o_duns on competitive_prods_org (duns) nologging;
create bitmap index bm_competitive_prods_o_manuf on competitive_prods_org(prod_manufacturer) nologging;
create bitmap index bm_competitive_prods_o_model on competitive_prods_org(prod_model) nologging;
create bitmap index bm_competitive_prods_o_t3 on competitive_prods_org(oracle_tier3) nologging;
create bitmap index bm_competitive_prods_o_t4 on competitive_prods_org(oracle_tier4) nologging;
create bitmap index bm_competitive_prods_o_t5 on competitive_prods_org(oracle_tier5) nologging;
create bitmap index bm_competitive_prods_o_t6 on competitive_prods_org(oracle_tier6) nologging;
create bitmap index bm_competitive_prods_o_vendor on competitive_prods_org(vendor) nologging;
create index bt_competitive_prods_o_org on competitive_prods_org (org_id) nologging;

-- MKTGCD kcierpisz
drop table competitive_prods;
create table competitive_prods as
select * from competitive_prods@jupiter_kcierpisz;
--create index bt_compet_prods_duns on competitive_prods (duns);
grant select on competitive_prods to public;

create index bt_competitive_prods_duns on competitive_prods (duns);
create bitmap index bm_competitive_prods_manuf on competitive_prods(prod_manufacturer);
create bitmap index bm_competitive_prods_model on competitive_prods(prod_model);
create bitmap index bm_competitive_prods_t3 on competitive_prods(oracle_tier3);
create bitmap index bm_competitive_prods_t4 on competitive_prods(oracle_tier4);
create bitmap index bm_competitive_prods_t5 on competitive_prods(oracle_tier5);
create bitmap index bm_competitive_prods_t6 on competitive_prods(oracle_tier6);
create bitmap index bm_competitive_prods_vendor on competitive_prods(vendor);

-- with_orgs
drop table competitive_prods_org;
create table competitive_prods_org nologging as
select * from competitive_prods_org@jupiter_kcierpisz;
--create index bt_compet_prods_duns on competitive_prods (duns);
grant select on competitive_prods_org to public;

--select * from competitive_prods a
--where nvl(a.oracle_tier6,'n/a') <> 'n/a'

-- with org_ids
create index bt_competitive_prods_o_duns on competitive_prods_org (duns) nologging;
create bitmap index bm_competitive_prods_o_manuf on competitive_prods_org(prod_manufacturer) nologging;
create bitmap index bm_competitive_prods_o_model on competitive_prods_org(prod_model) nologging;
create bitmap index bm_competitive_prods_o_t3 on competitive_prods_org(oracle_tier3) nologging;
create bitmap index bm_competitive_prods_o_t4 on competitive_prods_org(oracle_tier4) nologging;
create bitmap index bm_competitive_prods_o_t5 on competitive_prods_org(oracle_tier5) nologging;
create bitmap index bm_competitive_prods_o_t6 on competitive_prods_org(oracle_tier6) nologging;
create bitmap index bm_competitive_prods_o_vendor on competitive_prods_org(vendor) nologging;
create index bt_competitive_prods_o_org on competitive_prods_org (org_id) nologging;


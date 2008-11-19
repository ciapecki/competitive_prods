--KCIERPISZ

drop table tudla_prods_leg;
create table tudla_prods_leg as
SELECT distinct a.product_type vendor_prod_type, a.product_type category_name, a.product_code prod_name,
      manufacturer, prod_model model,
       
--       a.oracle_tier3,a.oracle_tier4, a.oracle_tier5, 
                     (case when a.oracle_tier3 is not null then a.oracle_tier3
             else (case when a.oracle_tier4 is not null then (select b.prod_tier3 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier4 = a.oracle_tier4 and rownum = 1)
                        when a.oracle_tier5 is not null then (select b.prod_tier3 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier5 = a.oracle_tier5 and rownum = 1)
                        when a.oracle_tier6 is not null then (select b.prod_tier3 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)
                    end)
        end) oracle_tier3,
       (case when a.oracle_tier4 is not null then a.oracle_tier4
             else (case when a.oracle_tier5 is not null then (select b.prod_tier4 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier5 = a.oracle_tier5 and rownum = 1)
                        when a.oracle_tier6 is not null then (select b.prod_tier4 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)
                    end)
        end) oracle_tier4,
       (case when a.oracle_tier5 is not null then a.oracle_tier5
             else (case when a.oracle_tier6 is not null then (select b.prod_tier5 from gsrt.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)    
                        end)
             end) oracle_tier5, 
       a.oracle_tier6
  FROM tudla.tudla_prods_leg_tmp a;
  
  grant select on tudla_prods_leg to tudla;
  
-- TUDLA
--drop table tudla_prods_leg;
drop table tudla_prods_leg_bak;
rename tudla_prods_leg to tudla_prods_leg_bak;
create table tudla_prods_leg as
select * from kcierpisz.tudla_prods_leg;
grant select on tudla_prods_leg to public;

--select * from hh_prods_leg_tmp

drop table hh_prods_leg_old;
rename hh_prods_leg to hh_prods_leg_old;
--drop table hh_prods_leg;
create table hh_prods_leg as
SELECT a.manufacturer || ' ' || a.product_model vendor_prod_code, 
		a.product_model vendor_description, a.groupp,
       a.manufacturer, a.product_model,
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
  FROM hh_prods_leg_tmp a;
  

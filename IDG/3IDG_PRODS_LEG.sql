-- IDG
-- idg_prods_leg_tmp -> prepared by Sean

--select * FROM idg_prods_leg_tmp

drop table idg_prods_leg_bak;
rename idg_prods_leg to idg_prods_leg_bak;
create table idg_prods_leg as
SELECT a.vendor_prod_type, a.category_name, a.prod_name,
      (case when upper(a.prod_name) like 'IBM%' then 'IBM' 
  			  when upper(a.prod_name) = 'DB2' then 'IBM'
			  when upper(a.prod_name) = 'SAP' then 'SAP'
			  when upper(a.prod_name) like 'SAP %' then 'SAP'
			  when upper(a.prod_name) like '%MICROSOFT%' then 'MICROSOFT'
			  when upper(a.prod_name) like '%BUS%OBJ%' then 'BUS-OBJECTS'
			  when upper(a.prod_name) = 'MS' then 'MICROSOFT'
			  when upper(a.prod_name) like 'MS ACC%' then 'MICROSOFT'
 			  when upper(a.prod_name) like 'MS SQL%' then 'MICROSOFT'
 			  when upper(a.prod_name) like 'SQL%SERVER' then 'MICROSOFT'
 			  when upper(a.prod_name) like 'MS WIN%' then 'MICROSOFT' 			  
			  when upper(a.prod_name) like 'MYSQL' then 'MYSQL AB'
 			  when upper(a.prod_name) like 'SIEBEL' then 'SIEBEL'
 			  when a.prod_manufacturer is not null then a.prod_manufacturer
		 end) manufacturer, 
		 (case when upper(a.prod_name) like 'IBM%DB2%' then 'DB2'
		 	   when upper(a.prod_name) = 'DB2' then 'DB2'
		 	   when upper(a.prod_name) like '%BUS%OBJ%' then 'BUS-OBJECTS'
   		 	   when upper(a.prod_name) like 'MS%SQL%' then 'SQL-SERVER'
   		 	   when upper(a.prod_name) like '%SQL%SERVER%' then 'SQL-SERVER'
	  		   when upper(a.prod_name) like 'MYSQL' then 'MYSQL'   		 	   
   	  		   when upper(a.prod_name) like 'MS ACC%' then 'ACCESS'   		 	   
   	  		   when a.prod_model is not null then a.prod_model
		  end) model,
       
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
  FROM idg_prods_leg_tmp a;
  
  grant select on idg_prods_leg to public;
  
  /*
    select distinct a.* from idg_prods_leg_tmp a
  where a.prod_manufacturer is not null
  
  select distinct a.* from idg_prods_leg a
  where a.manufacturer is not null
  */

grant select on cnet_prods_leg_tmp to cnet;

select * from cnet_prods_leg_tmp a where a.manuf is not null;

drop table cnet_prods_leg;
create table cnet_prods_leg as
SELECT a.vendor_prod_code, a.vendor_description, 
		(case when upper(a.vendor_prod_code) like 'IBM%' then 'IBM' 
			  when upper(a.vendor_prod_code) = 'SAP' then 'SAP'
			  when upper(a.vendor_prod_code) like 'SAP %' then 'SAP'
			  when upper(a.vendor_prod_code) like '%MICROSOFT%' then 'MICROSOFT'
			  when upper(a.vendor_prod_code) like '%BUS%OBJ%' then 'BUS-OBJECTS'
			  when upper(a.vendor_prod_code) = 'MS' then 'MICROSOFT'
			  when upper(a.vendor_prod_code) like 'MS %' then 'MICROSOFT'
			  when upper(a.vendor_prod_code) like 'MYSQL' then 'MYSQL AB'
 			  when upper(a.vendor_prod_code) like 'SIEBEL' then 'SIEBEL'
 			  when a.manuf is not null then a.manuf
		 end) manufacturer, 
		 (case when upper(a.vendor_prod_code) like 'IBM%DB2%' then 'DB2'
		 	   when upper(a.vendor_prod_code) = 'DB2' then 'DB2'
		 	   when upper(a.vendor_prod_code) like '%BUS%OBJ%' then 'BUS-OBJECTS'
   		 	   when upper(a.vendor_prod_code) like 'MS%SQL%' then 'SQL-SERVER'
   		 	   when upper(a.vendor_prod_code) like '%SQL%SERVER%' then 'SQL-SERVER'
	  		   when upper(a.vendor_prod_code) like 'MYSQL' then 'MYSQL'   		 	   
	  		   when a.model is not null then a.model
		  end) model,
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
  FROM cnet_prods_leg_tmp a;
  grant select on cnet_prods_leg to public;
 
  select * from cnet_prods_leg_tmp a
  where a.manuf is not null
   
  select * from cnet_prods_leg a
  where a.manufacturer is not null
  
  

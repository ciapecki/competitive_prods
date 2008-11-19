--FAIRFAX
create table fairfax_prods_leg_tmp as 
select * from kcierpisz.fairfax_prods_leg_tmp


drop table fairfax_prods_leg_old;
rename fairfax_prods_leg to fairfax_prods_leg_old;
create table fairfax_prods_leg as
SELECT a.vendor_prod_code, a.vendor_description, a."vendor_SCodeDesc",
       (case when upper(a."vendor_SCodeDesc") like 'IBM%' then 'IBM' 
			  when upper(a."vendor_SCodeDesc") = 'SAP' then 'SAP'
			  when upper(a."vendor_SCodeDesc") like 'SAP %' then 'SAP'
			  when upper(a."vendor_SCodeDesc") like '%MICROSOFT%' then 'MICROSOFT'
			  when upper(a."vendor_SCodeDesc") like '%BUS%OBJ%' then 'BUS-OBJECTS'
			  when upper(a."vendor_SCodeDesc") = 'MS' then 'MICROSOFT'
			  when upper(a."vendor_SCodeDesc") like 'MS ACC%' then 'MICROSOFT'
 			  when upper(a."vendor_SCodeDesc") like 'MS SQL%' then 'MICROSOFT'
 			  when upper(a."vendor_SCodeDesc") like 'MS WIN%' then 'MICROSOFT' 			  
			  when upper(a."vendor_SCodeDesc") like 'MYSQL' then 'MYSQL AB'
 			  when upper(a."vendor_SCodeDesc") like 'SIEBEL' then 'SIEBEL'
 			  when a.manuf is not null then a.manuf
		 end) manufacturer, 
		 (case when upper(a."vendor_SCodeDesc") like 'IBM%DB2%' then 'DB2'
		 	   when upper(a."vendor_SCodeDesc") = 'DB2' then 'DB2'
		 	   when upper(a."vendor_SCodeDesc") like '%BUS%OBJ%' then 'BUS-OBJECTS'
   		 	   when upper(a."vendor_SCodeDesc") like 'MS%SQL%' then 'SQL-SERVER'
   		 	   when upper(a."vendor_SCodeDesc") like '%SQL%SERVER%' then 'SQL-SERVER'
	  		   when upper(a."vendor_SCodeDesc") like 'MYSQL' then 'MYSQL'   		 	   
   	  		   when upper(a."vendor_SCodeDesc") like 'MS ACC%' then 'ACCESS'   		 	   
   	  		   when a.model is not null then a.model
		  end) model,
       --a.oracle_tier3, a.oracle_tier4, a.oracle_tier5,
              (case when a.oracle_tier3 is not null then a.oracle_tier3
             else (case when a.oracle_tier4 is not null then (select b.prod_tier3 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier4 = a.oracle_tier4 and rownum = 1)
                        when a.oracle_tier5 is not null then (select b.prod_tier3 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier5 = a.oracle_tier5 and rownum = 1)
                        when a.oracle_tier6 is not null then (select b.prod_tier3 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)
                    end)
        end) oracle_tier3,
       (case when a.oracle_tier4 is not null then a.oracle_tier4
             else (case when a.oracle_tier5 is not null then (select b.prod_tier4 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier5 = a.oracle_tier5 and rownum = 1)
                        when a.oracle_tier6 is not null then (select b.prod_tier4 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)
                    end)
        end) oracle_tier4,
       (case when a.oracle_tier5 is not null then a.oracle_tier5
             else (case when a.oracle_tier6 is not null then (select b.prod_tier5 from kcierpisz.gsrt_prod_hierarchy_staging b where b.prod_tier6 = a.oracle_tier6 and rownum = 1)    
                        end)
             end) oracle_tier5, 
       a.oracle_tier6
  FROM fairfax_prods_leg_tmp a;
  grant select on fairfax_prods_leg to public;
  

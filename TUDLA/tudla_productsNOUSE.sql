-- mKTGCD

SELECT *
  FROM lm_lad.tudla a
  where a.primary_application_brand_1 like '%/%' or a.primary_application_brand_1 like '%,%'


  create table tudla_products_1 (type varchar2(100), tudla_product varchar2(100), manufacturer varchar2(100), product_name varchar2(100));

-- done through dbi_product_tudla.rb script
  
  drop table fairfax_products_dist;
  create table fairfax_products_dist as
  select distinct * from fairfax_products a-- 656
  order by a.type, a.abr
  
-- delete from fairfax_products;commit;
 
-- add Taiwan
sbarsin.fairfax_company_mis_tai

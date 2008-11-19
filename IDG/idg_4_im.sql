create table idg_4_im as
SELECT a."CompanyID" company_id, a."CompanyName" company_name, 
        a."Address" company_addr1, a."City" company_city, a."State" company_state, a."Postcode" company_postcode,
       nvl(a."Country",'Australia') company_country, a."Phone" company_phone  
FROM tblcompanies a

grant select on idg_4_im to public;

select count(*) from idg_4_im

select * from all_tables@mktgcd_kcierpisz a
where a.owner = 'LM_LAD'
and a.table_name like '%TUDLA%'

/*
Requirements:
lm_lad.tudla_std_prod_final@mktgcd_kcierpisz

*/

select * from lm_lad.tudla_std_prod_final@mktgcd_kcierpisz

--- KCIERPISZ
rename tudla_final to tudla_final_bak;
create table tudla_final as
select * from lm_lad.tudla_final@mktgcd_kcierpisz;
grant select on tudla_final to tudla;
rename tudla_std_prod to tudla_std_prod_bak;
create table tudla_std_prod as
select * from lm_lad.tudla_std_prod@mktgcd_kcierpisz;
grant select on tudla_std_prod to tudla;

-- TUDLA
--drop table tudla_final;
drop table tudla_final_bak;
rename tudla_final to tudla_final_bak;
create table tudla_final as
select * from kcierpisz.tudla_final;
grant select on tudla_final to public;

drop tudla_std_prod_bak;
rename tudla_std_prod to tudla_std_prod_bak;
create table tudla_std_prod as
select * from kcierpisz.tudla_std_prod;
grant select on tudla_std_prod to public;

-- KCIERPISZ on JUPITER
create table idg_4_im_0608_matchout as
select * from lm_emea.IM202940_MATCHOUT@mktgcd_kcierpisz;
grant select on idg_4_im_0608_matchout to public;

--IDG
create table idg_4_im_0608_matchout as
select * from kcierpisz.idg_4_im_0608_matchout

select count(*), count(distinct a.company_id),
sum(case when a.dnb_duns_nbr is not null then 1 else 0 end) w_duns
 from idg_4_im_0608_matchout a

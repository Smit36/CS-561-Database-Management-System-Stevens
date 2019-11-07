with 

t1 as 
(select distinct prod from sales),

t2 as
(select distinct month from sales),

t3 as
(select distinct t1.prod,t2.month from t1,t2 order by t1.prod,t2.month),

t4 as
(select t3.prod,t3.month,sum(sales.quant) from t3 left join sales using (prod,month) group by t3.prod,t3.month order by t3.prod,t3.month),
 
t5 as
(select t4.prod, max(t4.sum), min(t4.sum) from t4 group by t4.prod),

t6 as
(select t4.prod, t4.month as most_fav_mo from t5,t4 where t5.max=t4.sum),

t7 as
(select t4.prod, t4.month as least_fav_mo from t5,t4 where t5.min=t4.sum )

select t6.prod, t6.most_fav_mo, t7.least_fav_mo from t6,t7 where t6.prod = t7.prod order by prod


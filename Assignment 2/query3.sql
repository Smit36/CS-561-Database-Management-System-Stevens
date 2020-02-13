with 
t1 as
(select prod, quant from sales order by prod, quant),

t2 as
(select prod, round((count(quant)/2)+1) as median from t1 group by prod order by prod),

t3 as
(select a.prod, a.quant, count(b.quant) from t1 as a join t1 as b on b.quant <= a.quant and a.prod = b.prod group by a.prod, a.quant order by a.prod, a.quant)

select t3.prod as product, t3.quant as "median quant" from t3 join t2 on t3.prod = t2.prod and t3.count = t2.median
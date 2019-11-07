with 

t1 as
(select cust,prod, avg(quant), count(quant),sum(quant) from sales group by cust,prod),

t2 as
(select cust, prod ,avg(quant) as q1_avg from sales where month between 1 and 3 group by cust,prod),

t3 as
(select cust, prod ,avg(quant) as q2_avg from sales where month between 4 and 6 group by cust,prod),

t4 as
(select cust, prod ,avg(quant) as q3_avg from sales where month between 7 and 9 group by cust,prod),

t5 as
(select cust, prod ,avg(quant) as q4_avg from sales where month between 10 and 12 group by cust,prod)



select t1.cust,t1.prod,t2.q1_avg,t3.q2_avg,t4.q3_avg,t5.q4_avg,t1.avg,t1.sum as total,t1.count from t1 left join t2 on t2.cust=t1.cust and t2.prod=t1.prod
left join t3 on t3.cust=t1.cust and t3.prod=t1.prod
left join t4 on t4.cust=t1.cust and t4.prod=t1.prod
left join t5 on t5.cust=t1.cust and t5.prod=t1.prod





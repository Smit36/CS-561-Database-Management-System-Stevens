with 
t1 as
(select cust, prod, state, round(avg(quant),0) as cust_avg from sales group by cust, prod, state),

t2 as
(select t1.cust, t1.prod, t1.state, t1.cust_avg, round(avg(s.quant),0) as  other_state_avg from t1, sales as s where t1.cust = s.cust and t1.prod = s.prod and t1.state != s.state group by t1.cust, t1.prod, t1.state, t1.cust_avg),

t3 as
(select t1.cust, t1.prod, t1.state, t1.cust_avg, round(avg(s.quant),0) as other_prod_avg from t1, sales as s where t1.cust = s.cust and t1.state = s.state and t1.prod != s.prod group by t1.cust, t1.prod, t1.state, t1.cust_avg)

select t1.cust as customer, t1.prod as product, t1.state, t1.cust_avg, t2.other_state_avg, t3.other_prod_avg from (t1 full outer join t2 on t1.cust=t2.cust and t1.prod=t2.prod and t1.state=t2.state) full outer join t3 on t1.cust=t3.cust and t1.prod=t3.prod and t1.state=t3.state order by t1.cust,t1.prod,t1.state

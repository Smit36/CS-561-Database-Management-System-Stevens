with 
t1 as 
(select cust, prod, month, sum(quant) from sales group by cust, prod, month order by cust, prod, month),

t2 as 
(select cust, prod, sum(sum) from t1 group by cust, prod),

t3 as 
(select a.cust, a.prod, a.month, a.sum, sum(b.sum) as running_sum from t1 as a join t1 as b on b.month <= a.month and a.cust = b.cust and a.prod = b.prod group by a.cust, a.prod, a.month, a.sum order by cust, prod, month), 

t4 as 
(select a.cust, a.prod, a.month from t3 as a, t2 as b where a.cust = b.cust and a.prod = b.prod and a.running_sum >= (2.0/3.0 * b.sum) order by cust, prod, month)

select cust, prod, min(month) as "2/3 purchased by month" from t4 group by cust, prod order by cust, prod
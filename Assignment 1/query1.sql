with

maxq as
(select max.prod as product,max.quant as max_q,max.cust as max_cust,max.day,max.month,max.year,max.state from (select prod, max(quant) as max_q from sales group by prod) as a
left join
(select * from sales) as max
on max.prod=a.prod and max.quant=a.max_q),

minq as
(select min.prod as product,min.quant as min_q,min.cust as min_cust,min.day,min.month,min.year,min.state from (select prod, min(quant) as min_q from sales group by prod) as b
left join
(select * from sales) as min
on min.prod=b.prod and min.quant=b.min_q),	

avgq as
(select prod, avg(quant) from sales group by prod)
	
	
select maxq.product,maxq.max_q,maxq.max_cust,concat(maxq.month,'/',maxq.day,'/',maxq.year) as max_date,maxq.state,minq.min_q,minq.min_cust,concat(minq.month,'/',minq.day,'/',minq.year) as min_date,minq.state,avgq.avg
from maxq join minq on maxq.product=minq.product join avgq on avgq.prod=maxq.product
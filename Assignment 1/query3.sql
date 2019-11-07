with 
months as 
(select generate_series as month from generate_series(1, 12)),
aggsale as
(select month, prod, sum(quant) from months left join sales using (month) group by month, prod), 
mostpop as 
(select distinct on (month) month, prod, sum from aggsale order by month, sum desc), 
leastpop as 
(select distinct on (month) month, prod, sum from aggsale order by month, sum asc)

select mostpop.month, mostpop.prod as most_popular_prod, mostpop.sum as most_pop_total_q, leastpop.prod as least_popular_prod, leastpop.sum as least_pop_total_q from mostpop join leastpop using (month)
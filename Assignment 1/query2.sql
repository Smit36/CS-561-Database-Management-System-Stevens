with

mix as 
(select cust, prod, max(quant) as max, min(quant) as min from sales group by cust, prod,state),

nymax as 
(select cust as customer, prod as product, quant as quantity, day as nyday, month as nymonth, year as nyyear from sales where state='NY'),

njmin as 
(select cust as customer, prod as product, quant as quantity, day as njday, month as njmonth, year as njyear from sales where state='NJ' and year > 2000),

ctmin as 
(select cust as customer, prod as product, quant as quantity, day as ctday, month as ctmonth, year as ctyear from sales where state='CT' and year > 2000),

ny as (select ny.customer, ny.product, ny.quantity as ny_max, concat(ny.nymonth,'/',ny.nyday,'/',ny.nyyear) as nymax_date from (mix join nymax on mix.cust=nymax.customer and mix.prod=nymax.product and mix.max=nymax.quantity) as ny),
nj as (select nj.customer, nj.product, nj.quantity as nj_min, concat(nj.njmonth,'/',nj.njday,'/',nj.njyear) as njmin_date from (mix join njmin on mix.cust=njmin.customer and mix.prod=njmin.product and mix.min=njmin.quantity) as nj),
ct as (select ct.customer, ct.product, ct.quantity as ct_min, concat(ct.ctmonth,'/',ct.ctday,'/',ct.ctyear) as ctmin_date from (mix join ctmin on mix.cust=ctmin.customer and mix.prod=ctmin.product and mix.min=ctmin.quantity) as ct)

select * from ((ny natural full outer join nj) natural full outer join ct)
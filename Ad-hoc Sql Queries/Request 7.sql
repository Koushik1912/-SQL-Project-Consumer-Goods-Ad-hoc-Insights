#Request 7
/* Get the complete report of the Gross sales amount for the customer  “Atliq 
Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
high-performing months and take strategic decisions. 
The final report contains these columns: 
Month 
Year 
Gross sales Amount*/

with cte as (select monthname(date) as Month, year(date), 
round(sum(sold_quantity*gross_price),2) as gross_sales_amount
from fact_sales_monthly f
join fact_gross_price g
on f.product_code=g.product_code
join dim_customer c
on c.customer_code=f.customer_code
where customer= 'Atliq Exclusive'
group by Month, year(date) 
order by Month desc)

select *, gross_sales_amount/1000000 from cte

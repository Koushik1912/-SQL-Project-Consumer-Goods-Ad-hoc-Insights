#Request 10
/* Get the Top 3 products in each division that have a high 
total_sold_quantity in the fiscal_year 2021? The final output contains these 
fields, 
division 
product_code 
product 
total_sold_quantity 
rank_order*/

with cte1 as (select p.division, p.product_code, p.product,
		sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly f
join dim_product p
on f.product_code=p.product_code
where fiscal_year='2021'
group by p.division, p.product_code, p.product),

cte2 as ( select *,
		dense_rank() over(partition by division order by total_sold_quantity desc) as rank_order
from cte1)

select * from cte2
where rank_order <=3
limit 3;
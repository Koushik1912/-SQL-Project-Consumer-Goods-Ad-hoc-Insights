with 
cte_20 as
#Request 4
/* Follow-up: Which segment had the most increase in unique products in 
2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference */

(select p.segment, count(distinct(product_code)) as product_count_2020
from fact_sales_monthly f
join dim_product p
using(product_code)
where fiscal_year=2020
group by segment
order by product_count_2020 desc),
cte_21 as
(select p.segment, count(distinct(product_code)) as product_count_2021
from fact_sales_monthly f
join dim_product p
using(product_code)
where fiscal_year=2021
group by segment
order by product_count_2021 desc)

select *,
		(product_count_2021-product_count_2020) as difference	
from cte_20
join cte_21
using(segment)
order by difference desc;

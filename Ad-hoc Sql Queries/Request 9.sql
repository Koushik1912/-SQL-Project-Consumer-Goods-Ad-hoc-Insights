#Request 9
/* Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
channel 
gross_sales_mln 
percentage */

with cte as (select c.channel, 
round(sum(sold_quantity*gross_price)/1000000,2) as gross_sales_mln
from fact_sales_monthly fm
join fact_gross_price g
on fm.product_code=g.product_code
join dim_customer c
on c.customer_code=fm.customer_code
where fm.fiscal_year='2021'
group by channel
order by gross_sales_mln desc)

select *,
		concat(round(gross_sales_mln*100/(select sum(gross_sales_mln) from cte),2), '%') as percentage_contribution
        from cte;

#Request 6 
/* Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
customer_code 
customer 
average_discount_percentage*/

SELECT  dc.customer,
		dc.customer_code,
		ROUND(fp.pre_invoice_discount_pct * 100, 2)  as Avg_disc_pct 
    
FROM fact_pre_invoice_deductions as fp
INNER JOIN dim_customer as dc
ON fp.customer_code = dc.customer_code
WHERE fiscal_year = 2021 and market = "India"
ORDER BY Avg_disc_pct DESC
LIMIT 5;
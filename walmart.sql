use mentorness;
set sql_safe_updates=0;
describe walmartdata;


-- step 1 -add new column
set sql_safe_updates=0;
alter table walmartdata add column date_s date;

-- step 2- insert the new column with converted dates
update walmartdata set date_s = str_to_date(`date`,'%d-%m-%Y');

-- steps 3 - delete the previous date column
alter table walmartdata drop `date`;

-- steps 4 - change the name of the new column to old column's name
alter table walmartdata change column date_s `Date` date ;


-- question 1-- Retrieve all columns for sales made in a specific branch (e.g., Branch 'A').

select * 
      from walmartdata 
      where branch = "A";

-- question 2-- Find the total sales for each product line.

select product_line,sum(total) as total_sales 
	  from walmartdata 
      group by product_line;

-- question 3-- List all sales transactions where the payment method was 'Cash'.

select * 
      from walmartdata 
      where payment ="cash";

-- question 4-- Calculate the total gross income generated in each city. 

select city,sum(gross_income) as total_gross_income
      from walmartdata 
      group by city; 

-- question 5-- Find the average rating given by customers in each branch. 

select branch,round(avg(rating),2) as Avg_rating 
      from walmartdata 
      group by branch 
      order by Avg_rating desc;

-- question 6-- Determine the total quantity of each product line sold.

select product_line,sum(quantity) as total_quantity 
      from walmartdata 
      group by product_line 
      order by total_quantity ;

-- question 7-- List the top 5 products by unit price. 

select * 
      from walmartdata 
      order by unit_price 
      desc limit 5;

-- question 8 --Find sales transactions with a gross income greater than 30.

select * 
      from walmartdata 
      where gross_income>30 
      order by gross_income asc;

-- question 9    Retrieve sales transactions that occurred on weekends.

select * 
      from walmartdata  
      where dayofweek(`date`) in (1,7);


-- question 10   Calculate the total sales and gross income for each month.

    SELECT MONTHNAME(`DATE`) AS MONTH_NAME,
    SUM(TOTAL) AS TOTAL_SALES,
    SUM(GROSS_INCOME) AS TOTAL_GROSS_INCOME
    FROM 
    WALMARTDATA 
    GROUP BY 
    MONTH_NAME,month(`date`)
    ORDER BY 
    month(`date`) asc;
    

    
    -- QUESTION 11 Find the number of sales transactions that occurred after 6 PM. 
    
    SELECT count(*) AS number_of_transactions_after_6pm
          FROM 
          walmartdata
          WHERE 
          HOUR(STR_TO_DATE(`time`, '%H:%i:%s')) > 18
          OR (HOUR(STR_TO_DATE(`time`, '%H:%i:%s')) = 18 AND MINUTE(STR_TO_DATE(`time`, '%H:%i:%s')) > 0);


     select count(*) from WALMARTDATA where `time`>"18:00:00";
    

    
    -- question 12 List the sales transactions that have a higher total than the average total of all transactions. 
    
    select * 
          from walmartdata 
          where total >(select avg(total) from walmartdata);
     
     select avg (total) from walmartdata;
 
 
 
 -- question 13  Calculate the cumulative gross income for each branch by date
    
select branch,`date`,sum(gross_income) as Total_gross_income 
          from walmartdata 
          group by branch,`date`
          order by branch,`date`;
    
    -- question 14  Find the total cogs for each customer type in each city.
    
    select city,customer_type,sum(cogs) as total_cogs 
          from walmartdata 
		  group by city,customer_type 
          order by city,customer_type;

    
    
    










SELECT * FROM youtube1.walmart1;
SELECT  
	time,
 case
	when 'time' between '00:00:00' and '12:00:00' then 'morning'
	when 'time' between '12:01:00' and '16:00:00' then 'afternoon'
    else 'noon'
end as time_of_day
from walmart1;
alter table walmart1 ADD COLUMN TIME_OF_DAY VARCHAR(10); 
UPDATE walmart1
SET time_of_day=(
 case
	when 'time' between '00:00:00' and '12:00:00' then 'morning'
	when 'time' between '12:01:00' and '16:00:00' then 'afternoon'
    else 'noon'
end );

-- DAYMANE
SELECT DATE, dayname(DATE)
FROM walmart1;
alter table walmart1 ADD COLUMN day_name VARCHAR(10); 
UPDATE walmart1
set day_name= dayname(date);

-- month_name 
select  DATE, monthname(DATE)
FROM walmart1;
alter table walmart1 ADD COLUMN month_name VARCHAR(10); 
UPDATE walmart1
set month_name= monthname(date);

-- How many unique cities does the data have?
select count(distinct city ) from malwart1;

-- In which city is each branch?
select city , count(branch)
from malwart1
group by city; 

select distinct city ,branch
from malwart1;

-- How many unique product lines does the data have?
select distinct malwart1.Product_line from malwart1;

-- What is the most common payment method?
select sum(malwart1.Quantity) as qty,
malwart1.Payment 
from malwart1
group by Payment
order by qty desc ;

-- What is the most selling product line?
select sum(malwart1.Quantity) as qty,
malwart1.product_line
from malwart1
group by product_line
order by qty desc ;

 -- What is the total revenue by month?
 select month_name , sum(Total)
 from malwart1 
 group by month_name 
 order by sum(Total);
 
 SELECT * FROM youtube1.malwart1;

-- What month had the largest COGS?
select cogs from malwart1 order by cogs desc limit 1;

-- What product line had the largest revenue?
select product_line , sum(total) as revenue
from malwart1
group by product_line 
order by revenue desc;

-- What is the city with the largest revenue?
select city , round(sum(total),2) as revenue
from malwart1
group by city 
order by revenue desc;

-- What product line had the largest VAT?
select product_line , sum(tax5%) as  vat
from malwart 
group by product_line
order by vat desc;

 SELECT * FROM youtube1.malwart1;
-- Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales
select product_line , avg(total) as average_sale
case
	when 'product_line' >= average_sale then 'good'
	else 'bad'
end as pl
from malwart1;

-- Which branch sold more products than average product sold?
select branch , sum(quantity) as qty
from malwart1 
group by branch
having sum(quantity)> (select avg(quantity) from malwart1) ;

-- What is the most common product line by gender?
select gender , product_line , count(gender)
from malwart1
group by gender
order by count(gender) desc;

-- What is the average rating of each product line?
select product_line , avg(rating) as avg_rat
from malwart1
group by product_line;

----------------------------------------- customer ----------------------------------------
select * from walmart1;
-- How many unique customer types does the data have?
select distinct Customer_type from walmart1;

-- How many unique payment methods does the data have?
select distinct payment from walmart1;

-- What is the most common customer type?
select count(*) as customer_count , Customer_type
from walmart1
group by  customer_type
order by customer_count desc ;

-- Which customer type buys the most?
select Customer_type , count(*)
from walmart1
group by Customer_type;

-- What is the gender of most of the customers?
select count(*), gender
from walmart1
group by gender;

-- What is the gender distribution per branch?
select  gender , count(*) as gender_cnt
from walmart1
where Branch='a'  # a, b 
group by gender;

select * from walmart1;
-- Which time of the day do customers give most ratings?
select time_of_day , avg(Rating)
from  walmart1
group by time_of_day
order by avg(Rating) desc;

-- Which time of the day do customers give most ratings per branch?
select time_of_day , avg(Rating), branch
from  walmart1
group by Branch ,time_of_day
order by avg(Rating) desc;

-- Which day fo the week has the best avg ratings?
select day_name , round(avg(rating), 2)
from walmart1
group by day_name;

-- Which day of the week has the best average ratings per branch?
select day_name , round(avg(rating), 2) as avg_rat
from walmart1
group by day_name
order by avg_rat desc;


-- ------------------- sales-------------------------
-- Number of sales made in each time of the day per weekday
select count(*) as no_sale , time_of_day
from walmart1
where day_name='sunday'
group by time_of_day;

-- Which of the customer types brings the most revenue?
select customer_type, round(sum(total),2) as revenue
from walmart1
group by customer_type
order by revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select * from walmart1;
select city , avg(tax) as vat 
from walmart1
group by city 
order by vat desc;

-- Which customer type pays the most in VAT?
select customer_type , avg(tax) as vat
from walmart1
group by Customer_type
order by vat desc;

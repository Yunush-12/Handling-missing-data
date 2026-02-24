create database company6;
create table sales 
(customer_id int, name varchar(50), city varchar(50), monthly_sales varchar(50), income varchar(50), region varchar(50));
insert into sales
values(101, 'Rahul Mehta', 'Mumbai', 12000, 65000, 'West'),
		(102, 'Anjali Rao', 'Bengaluru', 'null', 'null', 'south'),
    (103, 'Suresh Iyer', 'Chennai', 15000, 72000, 'South'),
    (104, 'Neha Singh', 'Delhi', 'null', 'null', 'North'),
    (105, 'Amit Verma', 'Pune', 18000, 58000, 'null'),
    (106, 'Karan Shah', 'Ahmedabad', 'null', 61000, 'West'),
    (107, 'Pooja Das', 'Kolkata', 14000, 'null', 'East'),
    (108, 'Riya Kapoor', 'Jaipur', 16000, 69000, 'North');
    
    -- 8 Listwise deletion
    -- remove all rows where REGION is missing
    -- task:
    -- 1 identify affected rows
    -- 2 show the dataset after deletion
    -- 3 mention how many records were lost
    -- asnwer 1
  delete from sales
  where region = 'null';
   -- answer 2
   select * from sales;
   -- answer 3
   -- only one records were lost
   
   -- 9 Imputation
   -- Handle missing values in monthly_sales using:
   -- forward fill
   -- Tasks:
   -- 1 Apply forward fill 
   -- 2 show before vs after values
   -- 3 explain why forward fill is suitable here
   
   -- answer 1 
   select
    Customer_id,
    name,
    city,
    coalesce(
	monthly_sales,
	last_value(monthly_sales) ignore nulls
	over (order by customer_id rows between unbounded preceding and current row))as monthly_sales_filled,
    income,
    region
from sales;
-- answer 2 
select * from sales;
-- answer 3
-- Sales data often follows a sequential order (e.g., monthly records).
-- Forward fill ensures continuity by carrying forward the last known sales figure instead of leaving gaps.
-- It avoids introducing artificial averages that may distort trends.

-- 10 flagging missing data
--  create a flag column for missing income
-- Tasks:
-- 1 create income_missing_flag (0 = present , 1 = missing)
-- 2 show updated dataset
-- 3 count how many customers have missing income

-- answer 1 
select
customer_id,
name,
city,
monthly_sales,
income,
region,
case
when income is null then 1 
        else 0 
    end as Income_Missing_Flag
from sales;
-- answer 2
select * from sales;
-- answer 3
select count(*) as Missing_Income_Count
from sales
where income is null;





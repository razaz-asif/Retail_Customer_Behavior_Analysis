rename table `untitled spreadsheet - copy of customers` to `customer_data`;

Rename table `untitled spreadsheet - copy of transactions` to `transactions`;

Rename table `untitled spreadsheet - customer_status` to `Customer_status`;

Rename table `untitled spreadsheet - support_tickets` to `support_tickets`;

create table customers_copy AS select * from customer_data;

create table transactions_copy AS select * from transactions;

create table Customer_status_copy AS select * from Customer_status;

create table support_tickets_copy AS select * from support_tickets;


select *
from customers_copy;

select distinct city 
from customers_copy;

select distinct state
from customers_copy;

select distinct region
from customers_copy;

create table geo_mapping(
city varchar(50),
state varchar(50),
region varchar(20)
);

INSERT INTO geo_mapping (city, state, region) VALUES
('Kolkata', 'West Bengal', 'East'),
('Chandigarh', 'Chandigarh', 'North'),
('Lucknow', 'Uttar Pradesh', 'North'),
('Pune', 'Maharashtra', 'West'),
('Mumbai', 'Maharashtra', 'West'),
('Jaipur', 'Rajasthan', 'North'),
('Chennai', 'Tamil Nadu', 'South'),
('Delhi', 'Delhi', 'North'),
('Ahmedabad', 'Gujarat', 'West'),
('Bangalore', 'Karnataka', 'South'),
('Hyderabad', 'Telangana', 'South');

set sql_safe_updates = 0;

update customers_copy 
join geo_mapping
on customers_copy.city = geo_mapping.city
set 
customers_copy.state = geo_mapping.state,
customers_copy.region = geo_mapping.region;


select *
from customers_copy;

----cleaning-signup_date

update customers_copy
set signup_date = case
 
when signup_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
   then date_format(STR_TO_DATE(signup_date, '%d/%m/%Y'), '%d-%m-%Y')

when signup_date regexp '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' 
   then date_format(STR_TO_DATE(signup_date, '%Y-%m-%d'), '%d-%m-%Y')

when signup_date regexp '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$' 
   then date_format(STR_TO_DATE(signup_date, '%d-%b-%Y'), '%d-%m-%Y')

when signup_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
   then date_format(STR_TO_DATE(signup_date, '%m/%d/%y'), '%d-%m-%Y')

ELSE signup_date
END
WHERE signup_date IS NOT NULL;

select *
from customer_status_copy;


----cleaning last_purchase_date

update customer_status_copy
set last_purchase_date = case
 
when last_purchase_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
    then date_format(STR_TO_DATE(last_purchase_date, '%d/%m/%Y'), '%d-%m-%Y')

when last_purchase_date regexp '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' 
     then date_format(STR_TO_DATE(last_purchase_date, '%Y-%m-%d'), '%d-%m-%Y')

when last_purchase_date regexp '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$' 
    then date_format(STR_TO_DATE(last_purchase_date, '%d-%b-%Y'), '%d-%m-%Y')

when last_purchase_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
then date_format(STR_TO_DATE(last_purchase_date, '%m/%d/%y'), '%d-%m-%Y')
    
 else last_purchase_date
 END
WHERE last_purchase_date 
  IS NOT NULL;


----cleaning churn_date

update customer_status_copy
set churn_date = case
 
when churn_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
    then date_format(STR_TO_DATE(churn_date, '%d/%m/%Y'), '%d-%m-%Y')

when churn_date regexp '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' 
   then date_format(STR_TO_DATE(churn_date, '%Y-%m-%d'), '%d-%m-%Y')

when churn_date regexp '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$' 
    then date_format(STR_TO_DATE(churn_date, '%d-%b-%Y'), '%d-%m-%Y')

when churn_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
   then date_format(STR_TO_DATE(churn_date, '%m/%d/%y'), '%d-%m-%Y')

ELSE churn_date
  END
WHERE churn_date 
  IS NOT NULL;


---cleaning transactions_copy

select *
from transactions_copy;

---cleaning_order_date

update transactions_copy
set order_date = case
 
when order_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
    then date_format(STR_TO_DATE(order_date, '%d/%m/%Y'), '%d-%m-%Y')

when order_date regexp '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' 
    then date_format(STR_TO_DATE(order_date, '%Y-%m-%d'), '%d-%m-%Y')

when order_date regexp '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$' 
    then date_format(STR_TO_DATE(order_date, '%d-%b-%Y'), '%d-%m-%Y')

when order_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
    then date_format(STR_TO_DATE(order_date, '%m/%d/%y'), '%d-%m-%Y')

ELSE order_date
   END
WHERE order_date 
IS NOT NULL;

select *
from support_tickets_copy;

---cleaning_ticket_date


update support_tickets_copy
set ticket_date = case
 
when ticket_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
    then date_format(STR_TO_DATE(ticket_date, '%d/%m/%Y'), '%d-%m-%Y')

when ticket_date regexp '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$' 
     then date_format(STR_TO_DATE(ticket_date, '%Y-%m-%d'), '%d-%m-%Y')

when ticket_date regexp '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{4}$' 
    then date_format(STR_TO_DATE(ticket_date, '%d-%b-%Y'), '%d-%m-%Y')

when ticket_date regexp '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
	then date_format(STR_TO_DATE(ticket_date, '%m/%d/%y'), '%d-%m-%Y')

ELSE ticket_date
  END
WHERE ticket_date
  IS NOT NULL;

------finding the latest activity per customers

select *
from(
    select*,
           row_number()over(
           partition by customer_id 
           order by order_date desc
            ) as rn
          from transactions_copy
)t
where rn = 1;

------finding total purchase_per_customers

select
     customer_id,
     COUNT(*)over(
     partition by customer_id
    ) as total_orders
from transactions_copy;

-----lifetime_value_percustomers

select *
from transactions_copy;

select
     customer_id,
     sum(revenue) over(
     partition by customer_id)
    as lifetime_revenue
from transactions_copy;

------how_long_between_purchases

select
     customer_id,
     order_date,
     LAG(order_date)over(
     partition by customer_id 
     order by order_date) as pervious_date
from transactions_copy;

----- top customers

select*,
      rank()over(
      order by lifetime_revenue desc
  ) as revenue_rank
from transactions_copy;

select *
from transactions_copy;

create view customer_behaviour as 
select
    customer_id,
    order_date,
   LAG(order_date)over(
    partition by customer_id order by order_date
) as pervious_transaction_date,
count(*)over(
    partition by customer_id
    ) as total_orders,
    sum(revenue)over(
    partition by customer_id
	)
as lifetime_revenue
from transactions_copy;
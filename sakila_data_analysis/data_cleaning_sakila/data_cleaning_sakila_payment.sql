/* ===========================================
   Table:payment
   Purpose: Exploratory checks and data validation
   Note: No cleaning performed on this table; only SELECT queries.
================================================== */
-- Inspect table structure
describe payment;

-- Identify Missing Data
select sum(amount is null) as null_amount,
sum(payment_date is null) as null_payment_date
from payment;

-- Check for invalid customer references
select p.customer_id 
from payment p 
left join customer c on p.customer_id=c.customer_id
where c.customer_id is null;

-- Check for invalid staff references
select p.staff_id
from payment p
left join staff s on p.staff_id=p.staff_id 
where s.staff_id is null;

-- Check for invalid rental references
select p.rental_id
from payment p 
left join rental r on r.rental_id=p.rental_id 
where r.rental_id is null;

-- Identify records
select * from payment 
where payment_date is null;

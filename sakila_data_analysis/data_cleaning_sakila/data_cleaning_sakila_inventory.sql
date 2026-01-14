/* ===========================================
   Table: inventory
   Purpose: Exploratory checks and data validation
   Note: No cleaning performed on this table; only SELECT queries.
================================================== */
-- Check for invalid film references
select v.film_id from inventory v left join film f 
on f.film_id =v.film_id 
where f.film_id is null;

-- Check for invalid store references
select v.store_id from inventory v left join store s 
on v.store_id = s.store_id 
where s.store_id is null;
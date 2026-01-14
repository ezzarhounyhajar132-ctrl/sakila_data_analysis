/* =====================================================
   Project: Sakila Data Cleaning & EDA
   Author: HajarEzzy
   Purpose: Data cleaning, standardization, and exploratory analysis
   Database: MySQL (Sakila)
   Created: 2025-11
   ===================================================== */

-- Create Working Table for Actor
create table actor_work like actor ;
insert actor_work select*from actor;

-- Review table structure
select * from actor_work;
describe actor_work;

-- Remove leading and trailing spaces
update actor_work
 set first_name = trim(first_name) , last_name = trim(last_name);
 
-- Convert names to proper case
update actor_work
 set first_name=concat(ucase(left(first_name,1)),lcase(substring(first_name,2))),
last_name=concat(ucase(left(last_name,1)),lcase(substring(last_name,2)));

-- Identify potential duplicate records using window functions
with tab_actor as(
select*, row_number() over(partition by first_name,last_name,last_update) as tab_row_num 
from actor_work
) select * from tab_actor 
   where tab_row_num>1;

-- Remove a specific record identified as invalid 
delete from actor_work 
where actor_id = 110;

-- Remove records with empty names
delete from actor_work
 where first_name = '' or last_name= '';
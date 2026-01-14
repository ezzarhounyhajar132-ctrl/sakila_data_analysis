# Sakila Data Cleaning & Exploratory Data Analysis (SQL)
## 📌 Project Overview

This project focuses on cleaning, standardizing, validating, and analyzing the Sakila sample database using **MySQL**.
The objective is to transform the raw relational data into clean, consistent, and analysis-ready tables, followed by **exploratory data analysis (EDA)** to uncover insights about film rentals, customers, and revenue.

This is a one-time data cleaning and exploratory analysis project.

---

## 🛠 Tools & Technologies
- MySQL 8.0
- SQL (CTEs, Window Functions, Joins, Aggregations)
- GitHub (Version Control)

---

## 📂 Project Structure
- data_cleaning_sakila.sql — SQL scripts for cleaning and standardizing all Sakila tables
- eda_sakila.sql — SQL queries for exploratory data analysis
- README.md — project documentation

## 📊 Data Source  
The Sakila sample database is provided by MySQL and is publicly available.
Due to its public nature, the raw database files are not included in this repository.
All core tables (actor, address, category, city, country, customer, film, film_actor, film_category, film_text, inventory, payment, rental, staff) were fully cleaned and validated before analysis.

## 🧹 Data Cleaning Steps

- Created staging and working tables to preserve original data
- Removed duplicate records using window functions
- Standardized text fields (trimming spaces, proper casing)
- Handled missing and NULL values
- Validated foreign key relationships across tables
- Cleaned and normalized phone numbers and postal codes
- Removed invalid or inconsistent records
- Ensured referential integrity between related tables

## 🔍 Exploratory Data Analysis (EDA)

- Analyzed film characteristics (length, rating, category)
- Identified most rented films and popular categories
- Examined customer activity and rental frequency
- Analyzed rental duration patterns
- Explored revenue distribution by:
--Customer
--Staff
--Film category
- Evaluated geographic distribution of customers and rentals

## 📈 Key Insights

- A small subset of films and categories generates a large share of rentals and revenue
- Customer activity follows a high-engagement vs low-engagement pattern
- Certain cities and regions contribute disproportionately to total rentals
- Revenue distribution is uneven across customers and staff, indicating key contributors

## 👩‍💻 Author

HajarEzzy
SQL | Data Cleaning | Data Analysis
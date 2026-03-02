Create database realestate;
use realestate;

-- Table Creation --

Create table properties(
built_up_area float,
avg_price_per_sqft float,
avg_of_property int,
possession_status varchar(200),
facing varchar(200),
furnishing varchar(200),
price float,
carpet_area float,
bedrooms float,
bathrooms float,
parking varchar(200),
balcony varchar(200),
covered_parking float,
open_parking float,
price_cr float);

select * from properties; 

ALTER TABLE properties
RENAME COLUMN avg_of_property TO age_of_property;

select * from properties; 

-- Avg price by bhk

create view price_by_bhk as 
select bedrooms , round(avg(price),0) as avg_price 
from properties
group by bedrooms; 

select * from price_by_bhk;

-- Top 10 Most Expensive Properties --

select * from properties; 

create view expensive_properties as
select bedrooms, price, built_up_area from properties
order by price desc
limit 10;

select * from expensive_properties; 

-- Average Price Per Sq.Ft --

select * from properties; 

create view avg_price as
select round(avg(avg_price_per_sqft),2) as avg_price_sqft
from properties;

select * from avg_price; 

select covered_parking as parking_count,
count(*) as total_properties,
round(avg(built_up_area),0) as avg_area,
round(avg(price),0) as avg_price,
ROUND(AVG(price/built_up_area),0) AS price_per_sqft from properties
group by covered_parking , built_up_area
order by covered_parking , built_up_area desc;

-- Does Parking Increase Price?--

create view property_kpi as
select covered_parking as parking_count,
count(*) as total_properties,
round(avg(built_up_area),0) as avg_area,
round(avg(price),0) as avg_price,
ROUND(AVG(price/built_up_area),0) AS price_per_sqft from properties
group by covered_parking , built_up_area
union all
select open_parking as parking_count,
count(*) as total_properties,
round(avg(built_up_area),0) as avg_area,
round(avg(price),0) as avg_price,
ROUND(AVG(price/built_up_area),0) AS price_per_sqft from properties
group by open_parking , built_up_area;

select * from property_kpi; 

-- Price by Age of Property-- 

select * from properties;

create view property_price_by_age as
select age_of_property, round(avg(price),0) as avg_price 
from properties
group by age_of_property 
order by age_of_property;
 
 select * from property_price_by_age; 
 
 

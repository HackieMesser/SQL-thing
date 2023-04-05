#1a
select funding_total_usd::VARCHAR, cast(founded_at_clean as varchar) from tutorial.crunchbase_companies_clean_date

#2 still working
SELECT companies.category_code
,  COUNT(case when acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp > '0 days' and acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp  < '1095 days' then 1 else null end) as within_3,
 COUNT(case when acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp > '1095 days' and acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp  < '1825 days' then 1 else null end) as within_5,
 COUNT(case when acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp > '1825 days' and acquisitions.acquired_at_cleaned::timestamp  - companies.founded_at_clean::timestamp  < '3650 days' then 1 else null end) as within_10, count(acquisitions.acquired_at_cleaned)

  FROM tutorial.crunchbase_companies_clean_date companies
  JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions
    ON acquisitions.company_permalink = companies.permalink
  group by companies.category_code

#almost but this is better  
SELECT companies.category_code,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '3 years'
                       THEN 1 ELSE NULL END) AS acquired_3_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '5 years'
                       THEN 1 ELSE NULL END) AS acquired_5_yrs,
       COUNT(CASE WHEN acquisitions.acquired_at_cleaned <= companies.founded_at_clean::timestamp + INTERVAL '10 years'
                       THEN 1 ELSE NULL END) AS acquired_10_yrs,
       COUNT(1) AS total
  FROM tutorial.crunchbase_companies_clean_date companies
  JOIN tutorial.crunchbase_acquisitions_clean_date acquisitions
    ON acquisitions.company_permalink = companies.permalink
 WHERE founded_at_clean IS NOT NULL
 GROUP BY 1
 ORDER BY 5 DESC

#3

select*from tutorial.sf_crime_incidents_2014_01

select position(',' in location) from tutorial.sf_crime_incidents_2014_01;

SELECT location, substr(location,(position(',' in location))+1,(position(')' in location)-2)) as lon, substr(location,2,(position(',' in location))-2) as lat
FROM tutorial.sf_crime_incidents_2014_01

SELECT location,
       TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) - 1)) AS lattitude,
       TRIM(trailing ')' FROM RIGHT(location, LENGTH(location) - POSITION(',' IN location) ) ) AS longitude
  FROM tutorial.sf_crime_incidents_2014_01


#concat 
select location, concat('(',lat,', ', lon,')') as "concat location"   FROM tutorial.sf_crime_incidents_2014_01 
alt way
select '('|| lat||', '|| lon||')' as "concat location"   FROM tutorial.sf_crime_incidents_2014_01 
date concat
select substr("date",7,4)||'-'||left("date",2)||'-' ||substr("date",4,2) as new_date FROM tutorial.sf_crime_incidents_2014_01 


SELECT left(category,1)||right(lower(category),length(category)-1) as cleaned_cat 

  FROM tutorial.sf_crime_incidents_2014_01

SELECT 
       date, time, (substr(date,7,4)||'-'||left(date,2)||'-'||substr(date,4,2)||' '||time)::timestamp as date_time, (substr(date,7,4)||'-'||left(date,2)||'-'||substr(date,4,2)||' '||time)::timestamp + INTERVAL '1 week' as plusweek
  FROM tutorial.sf_crime_incidents_2014_01



select date_trunc('week', cleaned_date)::date as week, count(incidnt_num)  from  tutorial.sf_crime_incidents_cleandate group by 1 order by 1

SELECT incidnt_num,now() at time zone 'PST' - "cleaned_date" as how_long_ago from  tutorial.sf_crime_incidents_cleandate


select sub.* from (
                select * from tutorial.sf_crime_incidents_2014_01 where category='WARRANTS' )
      sub where sub.resolution='NONE' 



      
  select left(sub.date,2), avg(sub.county), sub.category  from
                        (select date, count(incidnt_num) as county, category FROM tutorial.sf_crime_incidents_2014_01 group by 1, 3) sub group by 1,3

    
   
select avg(sub.county), sub.category  from
                        (select left(date,2), count(incidnt_num) as county, category FROM tutorial.sf_crime_incidents_2014_01 group by 1, 3) sub group by 2

SELECT sub.category,
       AVG(sub.incidents) AS avg_incidents_per_month
  FROM (
        SELECT EXTRACT('month' FROM cleaned_date) AS month,
               category,
               COUNT(1) AS incidents
          FROM tutorial.sf_crime_incidents_cleandate
         GROUP BY 1,2
       ) sub
 GROUP BY 1

#wip
select * from (select "category", count(incidnt_num) from tutorial.sf_crime_incidents_cleandate GROUP by 1  order by 2 asc ) sub limit 3

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


#concat WIP
select location, concat('(',lat,', ', lon,')')   FROM tutorial.sf_crime_incidents_2014_01 

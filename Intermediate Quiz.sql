  SELECT (count(accounts.name)/count(sales_reps.id)) as counter FROM sqlchallenge1.accounts as "accounts" left join sqlchallenge1.sales_reps as "sales_reps" on sales_reps.id = accounts.sales_rep_id 
  left join sqlchallenge1.region as "region" on region.id = sales_reps.region_id  group by region.name

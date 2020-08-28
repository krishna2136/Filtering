     (business_id varchar(3), year int, month int, city varchar(20), review int)
;


select distinct business_id
from (select t.*,
             lag(year) over (partition by business_id order by year, month) as prev_year,
             lag(month) over (partition by business_id order by year, month) as prev_month,
             lag(rating) over (partition by business_id order by year, month) as prev_rating
      from us_business_monthly_review_growth t
     ) t
where rating >= $threshhold and prev_rating >= $threshhold and
      (year * 12 + month) = (prev_year * 12 + prev_month) + 1;
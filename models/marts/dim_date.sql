{{ config(materialized='table') }}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2010-01-01' as date)",
        end_date="cast('2025-12-31' as date)"
    ) }}
)

select
    cast(date_format(date_day, 'yyyyMMdd') as int) as date_key,
    cast(date_day as date)                         as date,
    year(date_day)                                 as year,
    month(date_day)                                as month_number,
    date_format(date_day, 'MMMM')                  as month_name,
    quarter(date_day)                              as quarter,
    dayofweek(date_day)                            as day_of_week,
    dayofmonth(date_day)                           as day_of_month,
    dayofyear(date_day)                            as day_of_year,
    weekofyear(date_day)                           as week_of_year,
    case 
        when dayofweek(date_day) in (1, 7) then 'Weekend' 
        else 'Weekday' 
    end as day_type,
    concat(cast(year(date_day) as string), '-Q', cast(quarter(date_day) as string)) as year_quarter
from date_spine
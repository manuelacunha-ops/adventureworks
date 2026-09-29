{{ config(materialized='table') }}

with bounds as (
    select
        min(cast(order_date as date)) as min_date,
        max(cast(order_date as date)) as max_date
    from {{ ref('stg_salesorderheader') }}
),

date_spine as (
    select date_add(min_date, pos) as date_day
    from bounds
    lateral view posexplode(sequence(0, datediff(max_date, min_date))) t as pos, val
)

select
    cast(date_format(date_day, 'yyyyMMdd') as int) as date_key,
    date_day,
    year(date_day)                         as year,
    month(date_day)                        as month_number,
    date_format(date_day, 'MMMM')          as month_name,
    quarter(date_day)                      as quarter,
    dayofweek(date_day)                    as day_of_week,
    dayofmonth(date_day)                   as day_of_month,
    dayofyear(date_day)                    as day_of_year,
    weekofyear(date_day)                   as week_of_year,
    case when dayofweek(date_day) in (1, 7) then 'Weekend' else 'Weekday' end as day_type,
    concat(cast(year(date_day) as string), '-Q', cast(quarter(date_day) as string)) as year_quarter
from date_spine
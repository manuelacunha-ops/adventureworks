{{ config(materialized='table') }}
-- bridge table for many-to-many: orders <-> sales reasons
-- warning: 19.47% of orders have 2+ reasons
-- joining this to fact_sales will multiply rows — always pre-aggregate
select
    sohsr.sales_order_id,
    sohsr.sales_reason_id,
    sr.sales_reason_name,
    sr.reason_type,
    sohsr.modified_date
from {{ ref('stg_salesorderheadersalesreason') }} sohsr
join {{ ref('stg_salesreason') }} sr
    on sohsr.sales_reason_id = sr.sales_reason_id
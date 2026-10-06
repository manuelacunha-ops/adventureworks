{{ config(materialized='table') }}
-- bridge table for many-to-many: orders <-> sales reasons
-- warning: 19.47% of orders have 2+ reasons
-- joining this to fact_sales will multiply rows — always pre-aggregate
-- "No Sales Reason": 8,453 orders (26.86%) have no reason assigned (79.7% of revenue)
select
    soh.sales_order_id,
    coalesce(shsr.sales_reason_id, 0) as sales_reason_id,
    coalesce(sr.sales_reason_name, 'No Sales Reason') as sales_reason_name,
    coalesce(sr.reason_type, 'No Reason Type') as reason_type,
    shsr.modified_date
from {{ ref('stg_salesorderheader') }} soh
left join {{ ref('stg_salesorderheadersalesreason') }} shsr
    on soh.sales_order_id = shsr.sales_order_id
left join {{ ref('stg_salesreason') }} sr
    on shsr.sales_reason_id = sr.sales_reason_id
with source as (
    select * from {{ source('adventure_works', 'salesorderheadersalesreason') }}
)

select
    cast(salesorderid as int)       as sales_order_id,
    cast(salesreasonid as int)      as sales_reason_id,
    cast(modifieddate as timestamp) as modified_date
from source
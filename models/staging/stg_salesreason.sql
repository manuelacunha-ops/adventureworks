with source as (
    select * from {{ source('adventure_works', 'salesreason') }}
)

select
    cast(salesreasonid as int)       as sales_reason_id,
    cast(name as string)             as sales_reason_name,
    cast(reasontype as string)       as reason_type,
    cast(modifieddate as timestamp)  as modified_date
from source
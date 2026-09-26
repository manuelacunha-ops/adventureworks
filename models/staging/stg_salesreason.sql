with source as (
    select * from {{ source('adventure_works', 'salesreason') }}
)

select
    salesreasonid,
    name as reason_name,
    reasontype,
    modifieddate
from source
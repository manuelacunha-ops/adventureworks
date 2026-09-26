with source as (
    select * from {{ source('adventure_works', 'salesorderheadersalesreason') }}
)

select
    salesorderid,
    salesreasonid,
    modifieddate
from source
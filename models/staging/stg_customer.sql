with source as (
    select * from {{ source('adventure_works', 'customer') }}
)

select
    customerid,
    personid,
    storeid,
    territoryid,
    accountnumber
from source
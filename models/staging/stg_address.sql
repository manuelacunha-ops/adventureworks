with source as (
    select * from {{ source('adventure_works', 'address') }}
)

select
    addressid,
    addressline1,
    addressline2,
    city,
    stateprovinceid,
    postalcode,
    spatiallocation,
    modifieddate
from source
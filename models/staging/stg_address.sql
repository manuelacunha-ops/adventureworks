with source as (
    select * from {{ source('adventure_works', 'address') }}
)

select
    cast(addressid as int)          as address_id,
    cast(addressline1 as string)    as address_line1,
    cast(addressline2 as string)    as address_line2,
    cast(city as string)            as city,
    cast(stateprovinceid as int)    as state_province_id,
    cast(postalcode as string)      as postal_code,
    cast(rowguid as string)         as row_guid,
    cast(modifieddate as timestamp) as modified_date
from source
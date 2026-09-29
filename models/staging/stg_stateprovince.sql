with source as (
    select * from {{ source('adventure_works', 'stateprovince') }}
)

select
    cast(stateprovinceid as int)         as state_province_id,
    cast(countryregioncode as string)    as country_region_code,
    cast(name as string)                 as state_province_name,
    cast(rowguid as string)              as row_guid,
    cast(modifieddate as timestamp)      as modified_date
from source
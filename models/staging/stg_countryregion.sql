with source as (
    select * from {{ source('adventure_works', 'countryregion') }}
)

select
    cast(countryregioncode as string)  as country_region_code,
    cast(name as string)               as country_name,
    cast(modifieddate as timestamp)    as modified_date
from source
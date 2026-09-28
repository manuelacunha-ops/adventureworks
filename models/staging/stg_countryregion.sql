with source as (
    select * from {{ source('adventure_works', 'countryregion') }}
)

select
    countryregioncode,
    name as country_name,
    modifieddate
from source
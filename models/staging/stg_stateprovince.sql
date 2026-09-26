with source as (
    select * from {{ source('adventure_works', 'stateprovince') }}
)

select
    stateprovinceid,
    stateprovincecode,
    countryregioncode,
    isonlystateprovinceflag,
    name as state_name,
    territoryid,
    modifieddate
from source
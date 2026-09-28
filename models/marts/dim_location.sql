with stg_address as (
    select * from {{ ref('stg_address') }}
),
stg_stateprovince as (
    select * from {{ ref('stg_stateprovince') }}
),
stg_countryregion as (
    select * from {{ ref('stg_countryregion') }}
)

select
    a.addressid as location_sk,
    a.addressid,
    a.city,
    sp.state_name,
    cr.country_name
from stg_address a
left join stg_stateprovince sp on a.stateprovinceid = sp.stateprovinceid
left join stg_countryregion cr on sp.countryregioncode = cr.countryregioncode
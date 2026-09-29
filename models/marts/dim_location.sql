{{ config(materialized='table') }}

select
    a.address_id,
    a.address_line1,
    a.address_line2,
    a.city,
    a.postal_code,
    sp.state_province_id,
    sp.state_province_name,
    cr.country_region_code,
    cr.country_name,
    a.modified_date
from {{ ref('stg_address') }} a
left join {{ ref('stg_stateprovince') }} sp
    on a.state_province_id = sp.state_province_id
left join {{ ref('stg_countryregion') }} cr
    on sp.country_region_code = cr.country_region_code
{{ config(materialized='table') }}

select
    c.customer_id,
    c.person_id,
    c.store_id,
    c.territory_id,
    c.account_number,
    -- customer name: person name for b2c, store name for b2b
    case
        when pe.first_name is not null then concat(coalesce(pe.first_name, ''), ' ', coalesce(pe.last_name, ''))
        when s.store_name is not null then s.store_name
        else cast(c.customer_id as string)
    end as customer_name,
    -- dual identity (b2c vs b2b)
    case
        when c.person_id is not null and c.store_id is null then 'B2C (Individual)'
        when c.store_id is not null and c.person_id is null then 'B2B (Store)'
        when c.person_id is not null and c.store_id is not null then 'Both'
        else 'No identity'
    end as customer_type,
    pe.first_name,
    pe.last_name,
    s.store_name,
    c.modified_date
from {{ ref('stg_customer') }} c
left join {{ ref('stg_person') }} pe
    on c.person_id = pe.person_id
left join {{ ref('stg_store') }} s
    on c.store_id = s.business_entity_id
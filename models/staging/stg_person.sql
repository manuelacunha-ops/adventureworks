with source as (
    select * from {{ source('adventure_works', 'person') }}
)

select
    businessentityid as person_id,
    persontype as person_type,
    title,
    firstname as first_name,
    middlename as middle_name,
    lastname as last_name,
    concat(coalesce(firstname, ''), ' ', coalesce(lastname, '')) as full_name,
    emailpromotion as email_promotion
from source
with source as (
    select * from {{ source('adventure_works', 'person') }}
)

select
    businessentityid as personid,
    persontype,
    title,
    firstname,
    middlename,
    lastname,
    concat(coalesce(firstname, ''), ' ', coalesce(lastname, '')) as fullname,
    emailpromotion
from source
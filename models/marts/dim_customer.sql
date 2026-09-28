with stg_customer as (
    select * from {{ ref('stg_customer') }}
),
stg_person as (
    select * from {{ ref('stg_person') }}
)

select
    c.customerid as customer_sk,
    c.customerid,
    c.personid,
    c.storeid,
    c.territoryid,
    p.fullname as customer_name
from stg_customer c
left join stg_person p on c.personid = p.personid
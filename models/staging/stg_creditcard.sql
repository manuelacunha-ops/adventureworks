with source as (
    select * from {{ source('adventure_works', 'creditcard') }}
)

select
    creditcardid,
    cardtype,
    cardnumber,
    expmonth,
    expyear,
    modifieddate
from source
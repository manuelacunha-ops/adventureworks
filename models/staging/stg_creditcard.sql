with source as (
    select * from {{ source('adventure_works', 'creditcard') }}
)

select
    cast(creditcardid as int)          as credit_card_id,
    cast(cardtype as string)           as card_type,
    cast(cardnumber as string)         as card_number,
    cast(expmonth as int)              as exp_month,
    cast(expyear as int)               as exp_year,
    cast(modifieddate as timestamp)    as modified_date
from source
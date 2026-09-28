with stg_creditcard as (
    select * from {{ ref('stg_creditcard') }}
)

select
    creditcardid as credit_card_sk,
    creditcardid,
    cardtype
from stg_creditcard
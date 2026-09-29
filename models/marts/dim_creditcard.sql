{{ config(materialized='table') }}

select
    credit_card_id,
    card_type,
    card_number,
    exp_month,
    exp_year,
    modified_date
from {{ ref('stg_creditcard') }}
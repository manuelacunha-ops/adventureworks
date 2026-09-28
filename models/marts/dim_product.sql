with stg_product as (
    select * from {{ ref('stg_product') }}
)

select
    productid as product_sk,
    productid,
    product_name,
    productnumber,
    color,
    standardcost,
    listprice
from stg_product
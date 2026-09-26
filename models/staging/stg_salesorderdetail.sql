with source as (
    select * from {{ source('adventure_works', 'salesorderdetail') }}
)

select
    salesorderdetailid,
    salesorderid,
    orderqty,
    productid,
    specialofferid,
    unitprice,
    unitpricediscount,
    linetotal,
    modifieddate
from source
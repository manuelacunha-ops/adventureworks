with header as (
    select * from {{ ref('stg_salesorderheader') }}
),
detail as (
    select * from {{ ref('stg_salesorderdetail') }}
)

select
    concat(cast(detail.salesorderid as string), '-', cast(detail.salesorderdetailid as string)) as sales_item_sk,
    detail.salesorderid,
    detail.salesorderdetailid,
    header.orderdate,
    header.customerid,
    header.shiptoaddressid as location_id,
    header.creditcardid,
    detail.productid,
    detail.orderqty,
    detail.unitprice,
    detail.unitpricediscount,
    detail.linetotal
from detail
inner join header on detail.salesorderid = header.salesorderid
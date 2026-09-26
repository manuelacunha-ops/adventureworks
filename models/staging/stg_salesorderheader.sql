with source as (
    select * from {{ source('adventure_works', 'salesorderheader') }}
)

select
    salesorderid,
    revisionnumber,
    orderdate,
    duedate,
    shipdate,
    status,
    onlineorderflag,
    salesordernumber,
    purchaseordernumber,
    accountnumber,
    customerid,
    salespersonid,
    territoryid,
    billtoaddressid,
    shiptoaddressid,
    shipmethodid,
    creditcardid,
    subtotal,
    taxamt,
    freight,
    totaldue,
    modifieddate
from source
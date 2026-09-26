with source as (
    select * from {{ source('adventure_works', 'product') }}
)

select
    productid,
    name as product_name,
    productnumber,
    makeflag,
    finishedgoodsflag,
    color,
    safetystocklevel,
    reorderpoint,
    standardcost,
    listprice,
    size,
    weight,
    productsubcategoryid,
    productmodelid,
    sellstartdate,
    sellenddate,
    discontinueddate
from source
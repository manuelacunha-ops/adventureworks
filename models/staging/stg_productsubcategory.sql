with source as (
    select * from {{ source('adventure_works', 'productsubcategory') }}
)

select
    cast(productsubcategoryid as int)    as product_subcategory_id,
    cast(productcategoryid as int)       as product_category_id,
    cast(name as string)                 as subcategory_name,
    cast(rowguid as string)              as row_guid,
    cast(modifieddate as timestamp)      as modified_date
from source
with source as (
    select * from {{ source('adventure_works', 'productcategory') }}
)

select
    cast(productcategoryid as int)     as product_category_id,
    cast(name as string)               as category_name,
    cast(rowguid as string)            as row_guid,
    cast(modifieddate as timestamp)    as modified_date
from source
with source as (
    select * from {{ source('adventure_works', 'store') }}
)

select
    cast(businessentityid as int)       as business_entity_id,
    cast(name as string)                as store_name,
    cast(rowguid as string)             as row_guid,
    cast(modifieddate as timestamp)     as modified_date
from source
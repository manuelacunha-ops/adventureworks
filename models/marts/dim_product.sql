{{ config(materialized='table') }}

select
    p.product_id,
    p.product_name,
    p.product_number,
    p.color,
    p.list_price,
    p.standard_cost,
    p.product_line,
    p.class,
    p.style,
    p.size,
    p.weight,
    p.make_flag,
    p.finished_goods_flag,
    p.product_subcategory_id,
    coalesce(psc.subcategory_name, 'No Subcategory') as subcategory_name,
    psc.product_category_id,
    coalesce(pc.category_name, 'No Category')       as category_name,
    p.sell_start_date,
    p.sell_end_date,
    p.discontinued_date,
    p.modified_date
from {{ ref('stg_product') }} p
left join {{ ref('stg_productsubcategory') }} psc
    on p.product_subcategory_id = psc.product_subcategory_id
left join {{ ref('stg_productcategory') }} pc
    on psc.product_category_id = pc.product_category_id
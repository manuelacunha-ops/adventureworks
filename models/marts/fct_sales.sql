{{ config(materialized='table') }}

-- grain: one row per sales order line item (sales_order_detail_id)
-- additive measures: order_qty, net_sales, gross_sales, discount_amount
-- semi-additive (order-level, do NOT sum at line-item grain): subtotal, tax_amt, freight, total_due

select
    -- degenerate dimensions (for filtering, not summing)
    sod.sales_order_detail_id,
    soh.sales_order_id,
    soh.sales_order_number,

    -- dimension foreign keys
    cast(date_format(cast(soh.order_date as date), 'yyyyMMdd') as int) as order_date_key,
    cast(date_format(cast(soh.ship_date as date), 'yyyyMMdd') as int)  as ship_date_key,
    sod.product_id,
    soh.customer_id,
    soh.credit_card_id,
    soh.ship_to_address_id,
    soh.bill_to_address_id,

    -- order attributes (constant per order)
    soh.status,
    CASE soh.status
        WHEN 1 THEN 'In Process'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Backordered'
        WHEN 4 THEN 'Rejected'
        WHEN 5 THEN 'Shipped'
        WHEN 6 THEN 'Cancelled'
        ELSE 'Unknown'
    END AS status_description,
    soh.online_order_flag,
    soh.order_date,
    soh.ship_date,
    soh.due_date,
    soh.sales_person_id,
    soh.territory_id,

    -- additive measures (line-item grain)
    sod.order_qty,
    sod.unit_price,
    sod.unit_price_discount,
    sod.line_total                                              as net_sales,
    (sod.unit_price * sod.order_qty)                            as gross_sales,
    (sod.unit_price * sod.unit_price_discount * sod.order_qty)  as discount_amount,

    -- semi-additive (order-level — repeated per line item, do not sum)
    soh.subtotal,
    soh.tax_amt,
    soh.freight,
    soh.total_due
from {{ ref('stg_salesorderdetail') }} sod
join {{ ref('stg_salesorderheader') }} soh
    on sod.sales_order_id = soh.sales_order_id
-- Este teste valida se o valor de vendas brutas de 2011 bate com a auditoria ($12.646.112,16)
with sales_2011 as (
    select
        sum(gross_sales) as total_gross_sales
    from {{ ref('fact_sales') }}
    where order_date_key >= 20110101 and order_date_key <= 20111231
)

select
    total_gross_sales
from sales_2011
-- O dbt falhará se esta condição for verdadeira (diferença maior que 1 cêntimo/centavo)
where abs(total_gross_sales - 12646112.16) > 0.01
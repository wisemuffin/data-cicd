with orders as (
    select * from {{ ref('stg_orders' )}}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount
    from payments
    group by 1
),

final as (
    SELECT 
        orders.order_id,
        orders.customer_id,
        orders.order_date as date_orderd,
        null as must_not_be_null,
        coalesce(order_payments.amount, 0) + 100 as amount
    from orders
    left join order_payments on orders.order_id = order_payments.order_id
)

select *
from final
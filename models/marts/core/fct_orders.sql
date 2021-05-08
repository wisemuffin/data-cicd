with orders as   (
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
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date as date_ordered,
        'dave is a awesome' as awesome_column,
        coalesce(order_payments.amount, 0) +10 as amount
    from orders
    left join order_payments using (order_id)
    where coalesce(order_payments.amount, 0) < 30
)
select *
from final
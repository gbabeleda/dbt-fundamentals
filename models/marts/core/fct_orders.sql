with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

{# sum of amount per order#}
order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount
    from payments 

    group by 1
),

joined as (
    select 
        order_id,
        customer_id,
        order_date,
        coalesce(order_payments.amount,0) as amount

    from orders
    left join order_payments using (order_id)
)

select * from joined
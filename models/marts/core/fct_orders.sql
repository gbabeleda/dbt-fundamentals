with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

{# sum of amount per unique order_id with success status #}
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
        
        {# If there is a order with a null amount, replace with 0 #}
        coalesce(order_payments.amount,0) as amount

    {# Filters out customers with no orders #}
    from orders
    left join order_payments using (order_id)
)

select * from joined
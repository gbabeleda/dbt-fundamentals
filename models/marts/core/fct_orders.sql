with payments as (
    select
        orderid as order_id,
        amount
    
    from {{ ref('stg_payments') }}
),

orders as (
    select
        order_id,
        customer_id
    
    from {{ ref('stg_orders') }}
),

joined as (
    select
        order_id,
        customer_id,
        amount
    from payments 

    join orders 

    using(order_id)
)

select * from joined
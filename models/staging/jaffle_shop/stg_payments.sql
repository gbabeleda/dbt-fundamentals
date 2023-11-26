with payments as (

    select
        id as payment_id,
        orderid as order_id,
        status,
        paymentmethod as payment_method,
        amount / 100 as amount     
    
    from {{ source('stripe', 'payment') }}

)

select * from payments
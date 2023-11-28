with payments as (

    select
        id as payment_id,
        orderid as order_id,
        status,
        paymentmethod as payment_method,

        {# Stored in cents #}
        amount / 100 as amount,

        {# Extra credit for checking source freshness #}
        _batched_at
    
    from {{ source('stripe', 'payment') }}

)

select * from payments
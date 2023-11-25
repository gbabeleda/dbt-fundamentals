with payments as (

    select * from `dbt-tutorial`.stripe.payment

)

select * from payments
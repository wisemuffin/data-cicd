select
    customer_id,
    id as case_id,
    type,
    status,
    origin
from {{ source('jaffle_shop', 'case')}}
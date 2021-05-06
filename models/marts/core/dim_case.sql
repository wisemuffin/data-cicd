{{ config(
    tags=["pl"]
) }}

select
    case_id,
    type,
    status,
    origin
from {{ ref('stg_case') }}
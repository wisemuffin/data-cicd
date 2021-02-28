{%- set case_types = ['refund','suggestion'] -%}
with int_case as (
    select
        case_id,
        customer_id,
        status,
        origin,
        {{ dbt_utils.pivot('type', dbt_utils.get_column_values(ref('stg_case'),
                                                              'type'), suffix='_volume') }}
    from {{ ref('stg_case') }}
    group by
        case_id,
        customer_id,
        status,
        origin
)

select
    *
from int_case
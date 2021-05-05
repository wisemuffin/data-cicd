# Setup order

- start a free trial with snowflake
- [setup your AWS account's s3 with snowflake](https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration.html)
- to get some sample raw data
    - run ./access_controls/raw_base.sql (update IAM role)
    - ./access_controls/raw/*.sql
    - ./ddl/raw/*.sql
- then setup jaffle shop
    - ./access_controls/jaffle_shop_base.sql
    - ./access_controls/service_accounts/*.sql

- fivetran working on (i think this is just created by fivetran)



## CICD setup
run CDK in /infrastructure
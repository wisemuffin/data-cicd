//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
CREATE ROLE PC_FIVETRAN_USER;

// grant all roles to sysadmin (always do this)
GRANT ROLE PC_FIVETRAN_ROLE  TO ROLE SYSADMIN;

//=============================================================================
// grant privileges to object access roles
//=============================================================================

// permissions to PC_FIVETRAN_USER
GRANT USAGE ON DATABASE PC_FIVETRAN_DB TO ROLE PC_FIVETRAN_ROLE;
GRANT CREATE SCHEMA, USAGE ON DATABASE PC_FIVETRAN_DB TO ROLE PC_FIVETRAN_ROLE;
GRANT CREATE TABLE ON SCHEMA PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE TO ROLE PC_FIVETRAN_ROLE;
GRANT ALL PRIVILEGES ON WAREHOUSE FIVETRAN_WH   TO ROLE PC_FIVETRAN_ROLE;

GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE PC_FIVETRAN_ROLE;
GRANT USAGE ON SCHEMA SNOWFLAKE.ACCOUNT_USAGE TO ROLE PC_FIVETRAN_ROLE;
//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
CREATE ROLE FIVETRAN_READ_ROLE;

// grant all roles to sysadmin (always do this)
GRANT ROLE FIVETRAN_READ_ROLE  TO ROLE SYSADMIN;

//=============================================================================
// grant privileges to object access roles
//=============================================================================

// permissions to FIVETRAN_READ_ROLE
GRANT USAGE ON DATABASE PC_FIVETRAN_DB TO ROLE FIVETRAN_READ_ROLE;
GRANT USAGE ON SCHEMA PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE TO ROLE FIVETRAN_READ_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA  PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE to role FIVETRAN_READ_ROLE;
GRANT SELECT ON FUTURE TABLES IN SCHEMA  PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USAGE TO ROLE FIVETRAN_READ_ROLE;


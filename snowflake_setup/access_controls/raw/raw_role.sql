//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
CREATE ROLE RAW_ROLE;

// grant all roles to sysadmin (always do this)
GRANT ROLE RAW_ROLE  TO ROLE SYSADMIN;

//=============================================================================
// grant privileges to object access roles
//=============================================================================

// permissions to RAW_ROLE
GRANT USAGE ON DATABASE RAW TO ROLE RAW_ROLE;
GRANT CREATE SCHEMA, USAGE ON DATABASE RAW TO ROLE RAW_ROLE;
-- GRANT CREATE TABLE ON SCHEMA RAW.HASHMAP_SNOWFLAKE_USAGE TO ROLE RAW_ROLE;
-- GRANT ALL PRIVILEGES ON WAREHOUSE RAW_WH   TO ROLE RAW_ROLE;

-- GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE RAW_ROLE;
-- GRANT USAGE ON SCHEMA SNOWFLAKE.ACCOUNT_USAGE TO ROLE RAW_ROLE;
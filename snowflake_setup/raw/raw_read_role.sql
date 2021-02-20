//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
CREATE ROLE RAW_READ_ROLE;

// grant all roles to sysadmin (always do this)
GRANT ROLE RAW_READ_ROLE  TO ROLE SYSADMIN;

//=============================================================================
// grant privileges to object access roles
//=============================================================================

// permissions to RAW_READ_ROLE
GRANT USAGE ON DATABASE RAW TO ROLE RAW_READ_ROLE;
GRANT USAGE ON SCHEMA RAW.JAFFLE_SHOP TO ROLE RAW_READ_ROLE;
GRANT USAGE ON SCHEMA RAW.STRIPE TO ROLE RAW_READ_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA  RAW.JAFFLE_SHOP to role RAW_READ_ROLE;
GRANT SELECT ON FUTURE TABLES IN SCHEMA  RAW.JAFFLE_SHOP TO ROLE RAW_READ_ROLE;
GRANT SELECT ON ALL TABLES IN SCHEMA  RAW.STRIPE to role RAW_READ_ROLE;
GRANT SELECT ON FUTURE TABLES IN SCHEMA  RAW.STRIPE TO ROLE RAW_READ_ROLE;


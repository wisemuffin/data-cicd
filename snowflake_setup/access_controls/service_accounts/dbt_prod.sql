//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// prod warehouse
CREATE WAREHOUSE
    DBT_FUNDAMENTALS_PROD_WH
    COMMENT='Warehouse for powering CI prod activities for the jaffle shop project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// prod roles for ci (also not for humans)
CREATE ROLE DBT_FUNDAMENTALS_PROD_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE DBT_FUNDAMENTALS_PROD_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// prod permissions
GRANT USAGE ON WAREHOUSE DBT_FUNDAMENTALS_PROD_WH TO ROLE DBT_FUNDAMENTALS_PROD_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
// transformer roles
CREATE ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER TO ROLE SYSADMIN;

// prod OA roles 
GRANT ROLE DBT_FUNDAMENTALS_PROD_READ_WRITE TO ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
GRANT ROLE DBT_FUNDAMENTALS_PROD_WH_USAGE   TO ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
GRANT ROLE FIVETRAN_READ_ROLE                    TO ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
GRANT ROLE RAW_READ_ROLE                      TO ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER 
  DBT_DBT_FUNDAMENTALS_PROD_SERVICE_ACCOUNT
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the prod environment of the jaffle shop project.'
  DEFAULT_WAREHOUSE = DBT_FUNDAMENTALS_PROD_WH
  DEFAULT_ROLE = DBT_FUNDAMENTALS_PROD_TRANSFORMER
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER TO USER DBT_DBT_FUNDAMENTALS_PROD_SERVICE_ACCOUNT;
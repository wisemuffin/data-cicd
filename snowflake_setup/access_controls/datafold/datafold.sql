//=============================================================================
// create object access roles for databases
//=============================================================================
USE ROLE SECURITYADMIN;

// datafold role
CREATE ROLE DATAFOLDROLE;

// grant all roles to sysadmin (always do this)
GRANT ROLE DATAFOLDROLE TO ROLE SYSADMIN;

// datafold user
CREATE USER DATAFOLD_USER PASSWORD = '<SET PASSWORD HERE!>'
    DEFAULT_ROLE = "DATAFOLDROLE" MUST_CHANGE_PASSWORD = FALSE;
GRANT ROLE "DATAFOLDROLE" TO USER DATAFOLD_USER;


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// warehouse
CREATE WAREHOUSE
    DATAFOLD_WH
    COMMENT='Warehouse for powering datafold'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;

//=============================================================================
// setup datafold caching intermediate results via temp tables
//
// Repeat for every DATABASE to be usable in Datafold. This allows Datafold to
// correctly discover, profile & diff each table 
//=============================================================================

USE ROLE SYSADMIN;

CREATE SCHEMA DBT_FUNDAMENTALS_DEV.DATAFOLD_TMP;
CREATE SCHEMA DBT_FUNDAMENTALS_TEST.DATAFOLD_TMP;
CREATE SCHEMA DBT_FUNDAMENTALS_PROD.DATAFOLD_TMP;

USE ROLE SECURITYADMIN;

GRANT ALL ON SCHEMA DBT_FUNDAMENTALS_DEV.DATAFOLD_TMP TO DATAFOLDROLE;
GRANT ALL ON SCHEMA DBT_FUNDAMENTALS_TEST.DATAFOLD_TMP TO DATAFOLDROLE;
GRANT ALL ON SCHEMA DBT_FUNDAMENTALS_PROD.DATAFOLD_TMP TO DATAFOLDROLE;

//=============================================================================
// grant privileges to object access roles
//
// Repeat for every DATABASE to be usable in Datafold. This allows Datafold to
// correctly discover, profile & diff each table 
//=============================================================================
USE ROLE SECURITYADMIN;

GRANT USAGE ON WAREHOUSE DATAFOLD_WH TO ROLE DATAFOLDROLE;


// DBT_FUNDAMENTALS_DEV
GRANT USAGE ON DATABASE DBT_FUNDAMENTALS_DEV TO ROLE DATAFOLDROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE DBT_FUNDAMENTALS_DEV TO ROLE DATAFOLDROLE;

GRANT SELECT ON ALL TABLES IN DATABASE DBT_FUNDAMENTALS_DEV TO ROLE DATAFOLDROLE;
GRANT SELECT ON FUTURE TABLES IN DATABASE DBT_FUNDAMENTALS_DEV TO ROLE DATAFOLDROLE;


// DBT_FUNDAMENTALS_TEST
GRANT USAGE ON DATABASE DBT_FUNDAMENTALS_TEST TO ROLE DATAFOLDROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE DBT_FUNDAMENTALS_TEST TO ROLE DATAFOLDROLE;

GRANT SELECT ON ALL TABLES IN DATABASE DBT_FUNDAMENTALS_TEST TO ROLE DATAFOLDROLE;
GRANT SELECT ON FUTURE TABLES IN DATABASE DBT_FUNDAMENTALS_TEST TO ROLE DATAFOLDROLE;


// DBT_FUNDAMENTALS_PROD
GRANT USAGE ON DATABASE DBT_FUNDAMENTALS_PROD TO ROLE DATAFOLDROLE;
GRANT USAGE ON ALL SCHEMAS IN DATABASE DBT_FUNDAMENTALS_PROD TO ROLE DATAFOLDROLE;

GRANT SELECT ON ALL TABLES IN DATABASE DBT_FUNDAMENTALS_PROD TO ROLE DATAFOLDROLE;
GRANT SELECT ON FUTURE TABLES IN DATABASE DBT_FUNDAMENTALS_PROD TO ROLE DATAFOLDROLE;



//=============================================================================
// To provide column-level lineage, Datafold needs to read & parse all SQL statements
// executed in your Snowflake account
//=============================================================================

USE ROLE SECURITYADMIN;

GRANT MONITOR EXECUTION ON ACCOUNT TO ROLE DATAFOLDROLE;
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE DATAFOLDROLE;
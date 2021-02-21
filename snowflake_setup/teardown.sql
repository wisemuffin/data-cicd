USE ROLE SYSADMIN;
DROP DATABASE DBT_FUNDAMENTALS_DEV;
DROP DATABASE DBT_FUNDAMENTALS_PROD;
DROP DATABASE DBT_FUNDAMENTALS_TEST;
DROP WAREHOUSE DBT_FUNDAMENTALS_DEV_WH;
DROP WAREHOUSE DBT_FUNDAMENTALS_PROD_WH;
DROP WAREHOUSE DBT_FUNDAMENTALS_TEST_WH;

USE ROLE SECURITYADMIN;
DROP ROLE DBT_FUNDAMENTALS_DEV_READ_WRITE;
DROP ROLE DBT_FUNDAMENTALS_DEV_TRANSFORMER;
DROP ROLE DBT_FUNDAMENTALS_DEV_TRANSFORMER;
DROP ROLE DBT_FUNDAMENTALS_DEV_WH_ALL;
DROP ROLE DBT_FUNDAMENTALS_PROD_READ_WRITE;
DROP ROLE DBT_FUNDAMENTALS_PROD_TRANSFORMER;
DROP ROLE DBT_FUNDAMENTALS_PROD_WH_USAGE;
DROP ROLE DBT_FUNDAMENTALS_TEST_READ_WRITE;
DROP ROLE DBT_FUNDAMENTALS_TEST_TRANSFORMER;
DROP ROLE DBT_FUNDAMENTALS_TEST_WH_USAGE;
DROP USER DBT_DBT_FUNDAMENTALS_PROD_SERVICE_ACCOUNT;
DROP USER DBT_DBT_FUNDAMENTALS_PROD_SERVICE_ACCOUNT;
DROP USER SIGMA_DBT_FUNDAMENTALS_SERVICE_ACCOUNT;
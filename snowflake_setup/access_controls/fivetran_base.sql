//=============================================================================
// create databases -- done by FIVETRAN??
//=============================================================================
USE ROLE SYSADMIN;

// Databases
CREATE DATABASE PC_FIVETRAN_DB;


//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

use database PC_FIVETRAN_DB;

create schema HASHMAP_SNOWFLAKE_USAGE;
//=============================================================================
// setup raw database and schema
//=============================================================================

USE ROLE SYSADMIN;

create database raw;

use database raw;

create schema jaffle_shop;

create schema stripe;

create or replace file format csv
      type = CSV
      field_delimiter = ','
      skip_header = 1;

//=============================================================================
// create s3 AWS integration
//=============================================================================

USE ROLE ACCOUNTADMIN;

create storage integration s3_int
  type = external_stage
  storage_provider = s3
  storage_aws_role_arn = 'arn:aws:iam::ACCOUNT:role'
  enabled = true
  storage_allowed_locations = ('s3://dbt-tutorial-sf/');

grant usage on integration s3_int to role sysadmin;

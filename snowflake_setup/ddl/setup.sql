use database raw;

create schema jaffle_shop;

create schema stripe;

create or replace file format csv
      type = CSV
      field_delimiter = ','
      skip_header = 1;
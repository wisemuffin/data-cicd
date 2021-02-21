[![Production deployment from main](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml)
[![Test deployment from a PR](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml)
[![Test Production Data Quality](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
[![Test Data Freshness of Production](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)

# Testing out DBT



# 'slim' CICD

## Deployment of docs

TODO
- deploy to s3

## Data Quality and Freshness

I have set up two CI/CD jobs on a daily schedule to run all the automated tests, and check for source system freshness:

- [Run Data Quality Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
- [Run Source Data Freshness Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)

## Deployment & Pull requests

### Goals 
i want to only run models & tests for models, seeds, and tests that have changed. 

Run on each pull request, and create separate schemas for each pull request.

### Steps

- linting sql fluff
- fetch manifest.json at start of each run
- clone prod models into CI DB CAN REMOVE with --defer
- seed, run, test
- use --defer or zero copy clone?
- save state (artefact at the end of each run)

```bash
aws s3 cp s3://dbt-tutorial-sf/prod/manifest/manifest.json ./target/last_manifest/manifest.json

dbt seed --select state:modified --state ./target/last_manifest --full-refresh
dbt run --models state:modified --defer --state ./target/last_manifest
dbt test --models state:modified --defer --state ./target/last_manifest
```

localy test out storing manifest.json in aws s3
```bash

```

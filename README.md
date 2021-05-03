[![Production deployment from main](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml)
[![Test deployment from a PR](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml)
[![Test Production Data Quality](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
[![Test Data Freshness of Production](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)

# Testing out DBT

In this repo i am testing out setting up a CICD environment for dbt.

# Data Quality and Freshness

## DBT DQ and freshness

I have set up two CI/CD jobs on a daily schedule to run all the automated tests, and check for source system freshness:

- [Run Data Quality Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
- [Run Source Data Freshness Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)

## great expecations

Annother option is to use [great expectations](https://greatexpectations.io/)

# 'slim' CICD

## Merging Pull Requests into main branch CICD

### steps

- pull dbt models
- run dbt models
- save state (artefact at the end of each run)
- generate dbt docs
- host dbt docs on aws s3

## Pull requests CICD

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


### sqlfluff examples
```bash
sqlfluff fix test.sql
```

for PRs only new / modified code is reviewed. Test this by doing:

```bash
diff-quality --violations sqlfluff --compare-branch origin/main 
```


### Deploy tableau workbooks and data sources from PR

TODO

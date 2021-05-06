[![Production deployment from main](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod.yml)
[![Test deployment from a PR](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_test.yml)
[![Test Production Data Quality](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
[![Test Data Freshness of Production](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml/badge.svg)](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)


# Data CICD

This repo shows how you can utilise CICD to speed up data development.

Key to this is isolating every change (each feature/branch) against production data. Rebuilding your entire warehouse for each feature/branch would be supper expensive. However, if know your data lineage, you can build all the models you have changed and point them to production dependencies. This drastically reduces cost and time to test your changes.

## Goals of this project

- speed up incident response - lineage
- prevent breaking changes - regression, data profiling
- optimize the infrastructure - reduce CICD build times
- find the right data asset for the problem - data catalogue

## Standardizes code patterns - DBT

Lower barrier for new users to start contributing.
People understand each other’s code better and make fewer mistakes..

Data build tool [DBT](https://www.getdbt.com/) comes with some awesome features for CICD:

- Automated tests are configured or written in the same location as your data models.
- [DBT generated documentation](http://dbt-tutorial-sf.s3-website-ap-southeast-2.amazonaws.com/#!/overview) for this project are hosted on S3. This includes data lineage.
- Using [DBT's 'slim' CI](https://docs.getdbt.com/docs/guides/best-practices#run-only-modified-models-to-test-changes-slim-ci) best practice we can identify only the models that have changed.


## DBT slim CICD with github actions

Github actions have been set up to perform CICD:

- Merging Pull Requests into main branch CICD
- Pull requests CICD

***note*** that when entering in github secrets, the snowflake account includes the region e.g. cg00000.ap-southeast-2

### Merging Pull Requests into main branch CICD

#### steps

- pull dbt models
- run dbt models
- save state (artefact at the end of each run)
- generate dbt docs
- host dbt docs on aws s3

### Pull requests CICD

Here we want to give the developer feedback on:
- sql conforms to coding standards
- if models have regressed via DBT's automated testing.
- build out an isolated dev environment. This can be used to show end users and perform UAT.

#### Steps

- linting sql fluff
- fetch manifest.json at start of each run
- clone prod models into CI DB CAN REMOVE with --defer
- dbt seed, run, test only models whos state was modified
- save state (artefact at the end of each run)

#### example of DBT's 'slim' CI

```bash
aws s3 cp s3://dbt-tutorial-sf/prod/manifest/manifest.json ./target/last_manifest/manifest.json

dbt seed --select state:modified --state ./target/last_manifest --full-refresh
dbt run --models state:modified --defer --state ./target/last_manifest
dbt test --models state:modified --defer --state ./target/last_manifest
```


### sql linter sqlfluff

In order to standardise sql styles accross developer you can use a linter like sqlfluff to set coding standards.

example usage:

```bash
sqlfluff fix test.sql
```

for PRs only new / modified code is reviewed. Test this by doing:

```bash
diff-quality --violations sqlfluff --compare-branch origin/main 
```


### Deploy tableau workbooks and data sources from PR

TODO


## Data Quality and Freshness

### DBT DQ and freshness

I have set up two CI/CD jobs on a daily schedule to run all the automated tests, and check for source system freshness:

- [Run Data Quality Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_test_shedule.yml)
- [Run Source Data Freshness Tests](https://github.com/wisemuffin/dbt-tutorial-sf/actions/workflows/ci_prod_data_freshness_shedule.yml)

### great expecations

Another option is to use [great expectations](https://greatexpectations.io/)

- With [great expectations](https://greatexpectations.io/) as its decoupled from the transform layer (DBT) we can use [great expectations](https://greatexpectations.io/) during the ingest layer e.g. with spark.

### Data Quality - Datafold

With version control we are able to review code changes. However with data we also need to do regression testing to understand how our changes impact the state of the warehouse.

[Datafold](https://docs.datafold.com/using-datafold/data-diff-101-comparing-datasets) will automatically generate data profiling between your commit and a target e.g. production.

Checkout some of my pull/merge requests which contain a summary of data regression and links to more detailed profiling.

key features of [Datafold data diffing](https://docs.datafold.com/using-datafold/data-diff-101-comparing-datasets)
- table schema diff (which columns have changed)
- primary key not null or duplicate tests
- column data profiling (e.g. dev branch vs prod)
- data diff at a primary key level
- shows how datasets change over time

Other [Datafold](https://docs.datafold.com/using-datafold/data-diff-101-comparing-datasets) capabilities:
- data catalogue
- metric monitoring & alerting

#### Datafold best practices

- Use sampling when data profiling large data sets.

## Data Orchestration

See [airflow-dbt](https://github.com/wisemuffin/airflow-dbt)
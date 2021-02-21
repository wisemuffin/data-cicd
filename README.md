![](https://github.com/wisemuffin/dbt-tutorial-sf/workflows/Scheduled%20production%20run/badge.svg)
![](https://github.com/wisemuffin/dbt-tutorial-sf/workflows/Production%20deployment%20from%20main/badge.svg)

# Testing out DBT



# 'slim' CICD

## Goals
i want to only run models & tests for models, seeds, and tests that have changed. 

Run on each pull request, and create separate schemas for each pull request.

## Steps

- linting sql fluff
- fetch manifest.json at start of each run
- clone prod models into CI DB CAN REMOVE with --defer
- seed, run, test
- use --defer or zero copy clone?
- save state (artefact at the end of each run)

```bash
dbt seed --select state:modified --state ./target/last_manifest/manifest.json --full-refresh
dbt run --models state:modified --defer --state ./target/last_manifest
dbt test --models state:modified --defer --state ./target/last_manifest
```

localy test out storing manifest.json in aws s3
```bash

```

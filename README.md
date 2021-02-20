![](https://github.com/wisemuffin/dbt-snowflake-cost-monitoring/workflows/Scheduled%20production%20run/badge.svg)
![](https://github.com/wisemuffin/dbt-snowflake-cost-monitoring/workflows/Production%20deployment%20from%20main/badge.svg)

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### CICD slim TODO

i want to only run models & tests that have changed. 
run on each pull request

- linting sql fluff
- fetch manifest.json at start of each run
- clone prod models into CI DB CAN REMOVE with --defer
- seed, run, test
    - dbt seed --select state:modified --state prod_target_dir --full-refresh --target snowflake_dev
    - dbt run --models state:modified --defer --state prod_target_dir --target snowflake_dev
    - dbt test --models state:modified --defer --state prod_target_dir --target snowflake_dev
- use --defer or zero copy clone?
- save state (artifcats at the end of each run)

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

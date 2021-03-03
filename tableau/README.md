# limitations

- chaning schemas in tableau document manager cant be done.
- for UAT instead of creating a schema for each MR need to create new DB.
- for UAT need to create all models depending on exposures


# TODO create a trigger on branches named

- branch name = release/feature_name
- this will look for all exposure impacted 
- then zero copy clone prod
- then build just the models needed
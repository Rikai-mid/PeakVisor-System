# pianosystem

## Local test

Create config.local.yml file as below:
```
timeout: 30
db_name: <<LOCAL_DB_NAME>>
db_host: <<LOCAL_DB_HOST>>
db_username: <<LOCAL_DB_USERNAME>>
db_password: <<LOCAL_DB_PASSWORD>>
```

```
$ npm install -g serverless
$ npm install --save-dev serverless-offline
$ sls offline start
```

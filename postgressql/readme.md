# SQL on PostgresSQL

## Examples of sql in postgressql

## database 
Postgres database these are executed on is running in a docker container, connected to via VSCode with an extension "PostgreSQL" by Chris Kolkman

### Installation on docker

Simple steps followed from 
https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198 

```
docker pull postgres

mkdir postgressql

cd postgressql 

mkdir volumes 

docker run --rm --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v C:\postgressqql\volumes:/var/lib/postgresql/data postgres
```

### Connection to postgres instance 

psql -h localhost -U postgres -d postgres



## List of Concepts to include 
* create sanbox db 
* self join ( correlated Subqueries )
* apply operator 
* ranking queries, running aggregation
* NULL behaviour 
* common bugs 
* recursive CTEs
* inline TVFs
* union union all intersect except
* set variables

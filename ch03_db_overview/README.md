## Setting up Database
Let us setup database for our application using Postgres as part of Docker Container.
* Pull image `docker pull postgres`
* Create and start container using `docker run`
```shell script
docker run \
  --name pg_sms \
  -e POSTGRES_PASSWORD=itversity \
  -d \
  -p 5432:5432 \
  postgres
```
* We can review the logs by using `docker logs -f pg_chof` command.
* Connect to Postgres database using `docker exec`
```shell script
docker exec \
  -it pg_sms \
  psql -U postgres -W
```
* Create Database and User as part of Postgres running in Docker
```sql
CREATE DATABASE sms_db;
CREATE USER sms_user WITH ENCRYPTED PASSWORD 'itversity';
GRANT ALL PRIVILEGES ON DATABASE sms_db TO sms_user;
```

## Setting up SQLWorkbench
SQLWorkbench is an IDE to interact with Databases.

### Advantages
Here are some of the advantages of using IDEs such as SQLWorkbench.
* Once SQL Workbench is setup we don't need to struggle with CLI.
* We can access DB objects using user friendly interface.
* We can preview the details of objects as well as data with out running queries.
* We can write queries and preserve them directly and they will be available as back up for us.
* Using JDBC, we can use SQLWorkbench to connect to most of the industry standard databases such as MySQL, Postgres, Oracle etc.

### Setup Process
Here are the high level steps to setup SQLWorkbench.
* Download and Install SQLWorkbench
* Download the JDBC jar for the database you want to connect to. In our case Postgres.
* Validate the connectivity and spend some time in understanding some of the features.

## Creating Tables

```sql
\c sms_db

CREATE TABLE hw (
    i INT,
    s VARCHAR(30)
);

INSERT INTO hw VALUES (1, 'Hello');
INSERT INTO hw VALUES (2, 'World');

GRANT ALL ON TABLE hw to PUBLIC;
```

## Setup SQLAlchemy
* SQLAlchemy is an object-relational mapper (ORM), it helps us to interact with a database using Python functions and objects.
* It helps us to abstract away the SQL queries.

## Develop Model
Let us get an overview of defining models for our application.

## Connect Database
* To connect to the database we need to provide.
* Build the image
```
docker build -t ch03_db_overview .
```
* Start the Container. `pwd` will not work for Windows.
* ToDo: Get the instructions to mount on Windows.
```
docker run \
    --name ch03_db_overview_1 \
    -v `pwd`:/app \
    -p 5000:5000 \
    ch03_db_overview
```
* Now we can go to the URL and see if it is working as expected or not - http://localhost:5000
 
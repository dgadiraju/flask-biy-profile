## Docker Compose - Overview
Let us get an overview of Docker Compose.
* Docker Container will typically run one service at a time.
* For any standard application, we need to have multiple containers. In our case we need 2 containers as part of our development environment.
  * Web - Python with all dependent libraries.
  * Database - Database in which data is persisted.
* It will be a bit cumbersome to use Docker and create all the components related to the application and integrating them.
* **Docker Compose** will act as abstraction to take care of setting up the environment with all the components and integrate them.

## Docker Compose - Web
Let us see how to configure docker based environment for a simple web application.
* Here is the code for **app.py**.
```python
from flask import Flask

app = Flask(__name__)


@app.route('/')
def index():
    return 'Hello World, Getting Started'
```
* Web Application - docker-compose.yml
```yaml
version: '2.0'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
    command: ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
```
* We can use `docker-compose build` to build the custom web image for our application.
* Run `docker images` to see the image that is built - **ch04_docker_compose_web**.
* To start the web container we can run `docker-compose up`.
* We can stop the services managed by docker-compose using `docker-compose stop`.
* We can clean up all the containers, images, networks etc by using `docker-compose down --rmi all`.

## Docker Compose - Web and DB
Let us see how to configure docker based environment for a simple web application with DB.
* Here are the details
  * Define configuration for Database - `web`
  * Define configuration for Web Application - `db`
  * We can ensure `web` to be created after `db` using `depends_on`.
  * Creation of Database as part of the container will take some time. We can wait until database is created using custom scripts `wait-for-postgres.sh`.
  * `wait-for-postgres.sh` takes the container name of database `db` as argument.
  * We have customized `wait-for-postgres.sh` by adding additional commands to seed the database for the demo.

## Review Flask Application
Here are the details of the code we are going to use.
* We will use SQLAlchemy to interact with the database.
* We will use the same code as in previous chapter.

## Configure and Run Docker Compose
Let us define the `docker-compose.yml` file and validate whether application is up and running and able to talk to Database or not.
* Database and Web Application - docker-compose.yml
```yaml
version: '2.0'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
    depends_on:
      - "db"
    command: ["./wait-for-postgres.sh", "db", "flask", "run", "--host", "0.0.0.0", "--port", "5000"]
  db:
    image: postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: itversity
```
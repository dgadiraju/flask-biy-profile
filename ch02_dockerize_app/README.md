## Dockerize Application
### Docker Desktop
We can setup Docker Desktop on Windows or Mac.
* Docker Desktop will streamline the process of managing Docker Images and Containers.
* We should be able to use Windows Command Prompt or Mac Terminal to manage Docker components after setting up Docker Desktop.
```
docker version # Version of Docker installed
docker images # list all the images that are available
docker ps -a # list all the containers that are stopped or running
```
* Alternatively we can setup Docker on Ubuntu based machine as well.

### Setting up Docker Server
Here are the details to ensure you have Docker running on a server.
* Provision VM from GCP using Ubuntu 18.04.
* Setup Docker following instructions using digital ocean article from Google Search results.
* Make sure the user used for login into VM on Ubuntu is added to group docker.
```
sudo usermod -aG docker `whoami`
```
* Pull images and start containers.
```
docker pull hello-world
docker run hello-world
docker pull mysql
docker run --name mysql_container -p 5000:5000 -e MYSQL_ROOT_PASSWORD=itversity -d mysql
docker exec -it mysql_container bash
docker exec -it mysql_container mysql -u root -p
```
* Understand important commands related to managing images and containers.
Managing images - `docker image`

|Command           |Description |
|------------------|------------|
|docker image pull |Pull image  |
|docker image rm   |Remove image|
|docker image build|Build image |

Managing containers - `docker container`

|Command                |Description                       |
|-----------------------|----------------------------------|
|docker container create|Create Container                  |
|docker container start |Start Container                   |
|docker container run   |Build, Create and Start Container |
|docker logs            |Check logs of docker container    |
|docker container rm    |Remove Container                  |
|docker container ls    |List Container                    |

### Dockerize Application
Let us also dockerize our application so that we can streamline our development process.
* We will continue using Docker based approach to build run time environment to run the APIs.
* Create Dockerfile using Dockerfile of this repository
```dockerfile
FROM python:3.7

WORKDIR /app
COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

EXPOSE 5000
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]
```
* Build the image
```
docker build -t ch02_dockerize_app .
```
* Start the Container. `pwd` will not work for Windows.
* ToDo: Get the instructions to mount on Windows.
```
docker run \
    --name ch02_dockerize_app_1 \
    -v `pwd`:/app \
    -p 5000:5000 \
    ch02_dockerize_app
```
* Now we can go to the URL and see if it is working as expected or not - http://localhost:5000

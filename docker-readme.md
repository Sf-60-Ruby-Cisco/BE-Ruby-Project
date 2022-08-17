## What is Docker ?

Docker is an open-source containerization tool used to simplify the creation and deployment of applications by using the concept of containers. Containers allow us to package all the parts of an application and deploy it as one entity.

This tool makes it easy for different developers to work on the same project in the same environment without any dependencies or OS issues. Docker is sort of like a virtual machine, but Docker enables applications to access the same Linux kernel.

Docker offers many advantages for developers and DevOps teams. 
   Docker…
    - is highly demanded by companies large and small
    - offers isolation from the main system
    - simplifies configuration
    - provides access to thousands of configured images with Docker Hub
    - supports many CI tools like Travis and Jenkins
    - allows developers to focus just on writing code
    - simplifies deployment management for operations teams

Docker is commonly used alongside Kubernetes, a powerful container management tool that automates the deployment of your Docker containers. While Docker is used to isolate, pack, and ship your application into containers, Kubernetes is like the container scheduler for deploying and scaling the application.

The two technologies are designed to work together and make app deployment a breeze.

## Containers and images
Useful commands:
```
Gets containers list (running/stopped): docker ps -a
Gets running containers list:           docker ps
Gets image list:                        docker image ls
Starts a container:                     docker start container_id
Stops a running container:              docker stop container_id
Deletes a container that is stopped:    docker rm container_id
Build images declared in docker-compose.yml:
  docker-compose build
  docker-compose build --no-cache
  docker-compose -f "path/to/docker-compose.yml" build
Run your containers:
  docker-compose up
  docker-compose -f "path/to/docker-compose.yml" up
Remove containers and their data/volumes:
  docker-compose down --v
  docker-compose -f "path/to/docker-compose.yml" down --v
```
The basic structure of Docker relies on images and containers. Think of images and containers as two different states of the same underlying concept. A container is like an object, and an image is like its class.

Think of a container as an isolated system that contains everything needed to run a certain application. It is an instance of an image that simulates the required environment.

Images, on the other hand, are used to start-up containers. From running containers, we can get images, which can be composed together to form a system-agnostic way of packaging applications.

Images can be pre-built, retrieved from registries, created from already existing ones, or combined together via a common network.

## Dockerfiles

Dockerfiles are how we containerize our application, or how we build a new container from an already pre-built image and add custom logic to start our application. From a Dockerfile, we use the Docker build command to create an image.

Think of a Dockerfile as a text document that contains the commands we call on the command line to build an image.

## Docker Compose files

Docker Compose files work by applying mutiple commands that are declared within a single docker-compose.yml configuration file.


## Build and run locally
Add this code to config/environments/development.rb
under Rails.application.configure do
```
  config.hosts = [
    "192.168.99.100"
  ]
```

```
docker-compose -f "docker-compose.dev.yml" build
docker-compose -f "docker-compose.dev.yml" run web rake db:create
docker-compose -f "docker-compose.dev.yml" up
```

At this point, you should be able to navigate to http://localhost:3000
or http://192.168.99.100:3000 (Docker's default host)
in your local browser and see the app running.

## Build + Push to heroku steps:
Requires: Heroku CLI
```
heroku login
heroku container:login
heroku create
```
Note the app name it gives you when you do this. You’ll need it to configure the correct app in Heroku’s console later.

Add this code to config/environments/production.rb
under Rails.application.configure do
```
  config.hosts = [
    "heroku_app_name.herokuapp.com"
  ]
```

Set, in config/environments/production.rb, line 34. (unless nginx, etc.. is used)
```
  config.assets.compile = true
```

Add Postgres Addon to your Heroku app and then

Add your credentials to the .env file and edit the database.yml's production environment

Example:
config/database.yml
```
production:
  <<: *default
  database: car_diary_production
  url: 
  username: 
  password: 
  host: 
```


```
docker-compose -f "docker-compose.prod.yml" build
```

Push the web image to heroku
```
heroku container:push web -a heroku_app_name --recursive
```
-- recursive flag is needed for Heroku to use Dockerfile.web

Run
```
heroku run rake secret -a heroku_app_name
heroku config:set -a heroku_app_name SECRET_KEY_BASE=secret_key
```

Start the container in Heroku
```
heroku container:release web -a heroku_app_name
```

# How to do migrations on Heroku ?

```
heroku run rake db:migrate -a heroku_app_name
```

If you wanted to run migrations locally, you would do 
```
docker-compose -f "path/to/docker-compose.yml" run web rake db:migrate
```


### Useful links and info

Option 1. Docker Desktop
https://docs.docker.com/desktop/install/windows-install/
https://docs.docker.com/desktop/install/mac-install/
https://docs.docker.com/desktop/install/linux-install/

Option 2: Docker Toolbox (deprecated) For older Systems
https://jff--docker-docs.netlify.app/toolbox/toolbox_install_windows/
https://jff--docker-docs.netlify.app/toolbox/toolbox_install_mac/

Tip: One of the advantages of the newer Docker for Desktop solution is that it uses native virtualization and does not require VirtualBox to run Docker.

Dockerfile.web guide:
https://thelurkingvariable.com/2019/12/17/ruby-with-docker-compose-as-a-non-root-user/
https://lipanski.com/posts/dockerfile-ruby-best-practices

Reason for using: ruby:3.0.3-alpine3.13
Alpine 3.14 images can fail on Docker versions older than 20.10...
https://github.com/docker-library/ruby/issues/351

Useful more advanced guide:
https://www.jmaguire.tech/posts/dockerizing-rails-app/

Why do we need the entrypoint.sh? Source: https://docs.docker.com/samples/rails/
It  fix a Rails-specific issue that prevents the server from restarting when a certain server.pid file pre-exists. 
This script will be executed every time the container gets started.

Connect to a Heroku postgres database with pgadmin4:
https://towardsdatascience.com/how-to-connect-to-a-heroku-postgres-database-with-pgadmin4-using-docker-6ac1e423ae66

The Ultimate Docker Cheatsheet:
https://dockerlabs.collabnix.com/docker/cheatsheet/


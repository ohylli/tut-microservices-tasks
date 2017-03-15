# Node.js template for task 2

This directory contains a Node.js and express based application that you can use as a base for task 2. It is similar to and modified from the example scenario. It uses docker and docker compose. There are two node.js and express based applications (app1 and app2) that each run inside a docker container with an instance of the message bus. The app1 and app2 directories contain a dockerfile that specifies how to build docker images of the applications. Both images are based on a docker image that offers a node.js environment whose dockerfile is in this directory. This node.js image is based on the message bus image build in task 1. In other words you have to complete task 1 at least partially to use this. The application also uses the same docker network created in task 1.

To build all the docker images of this application you can execute the included build.sh script. Then you can use docker compose to start this application:

```
docker-compose up
```

The docker-compose.yaml file defines what kind of application is created. When the application is running both app1 and app2 are listening on port 3000 of their container.  These ports are also mapped to ports 3000 and 3001 of your docker host machine. So you can visit http://localhost:3000 and http://localhost:3001 to verify that the apps are running. You should see a welcome message from both apps. Inside the containers the message bus public api is listening on http://127.0.0.1:8080. The apps are just code skeletons generated with the [express application generator](https://expressjs.com/en/starter/generator.html)
tool.

Both app's docker containers use a process control system called [supervisor](http://supervisord.org/)
to start and in case of a crash to restart the node.js application and the message bus. The behaviour of supervisor is defined in the supervisord.conf files in the app1 and app2 directories.
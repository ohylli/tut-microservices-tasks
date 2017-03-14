# TUT Seminar on Microservices tasks

This repository contains additional material related to my presentation for 
[TUT Seminar on Microservices](https://sites.google.com/view/microservices/). It contains detailed instructions for tasks related to my presentation.

## Task 1

The source code of [the message bus](https://github.com/soulski/dmp)
and the [example scenario](https://github.com/soulski/dmp-scenario)
 are available at GitHub. The first task is to get them working. The code repositories don't contain any documentation so here are some tips that will help you in getting the code to work. 

### Requirements

I recommend doing everything in a Linux environment. I used a Ubuntu 16.04 virtual machine. You require the following:

- git: for getting the code and dependencies
- docker: the message bus and example scenario run inside docker containers
- docker compose: is used to manage a system composed of multiple containers
- [go](https://golang.org/doc/install): the implementation language for the systems. is required to compile the code
- make: used to manage the building and running of the systems

IMPORTANT NOTE: Newer versions of go starting from version 1.6 don't work with this apparently because they handle code dependencies differently.  I used go 1.5.4.

### Building the code

Note I have no experience with Go before this and just basic docker knowledge, so I might have misunderstood something or there might be a better way to do things. So if you find something wrong with these instructions let me know. 

For working with go projects go uses a workspace directory. It can be any directory on your system. The workspace directory is specified with the GOPATH environment variable.  The go workspace directory  requires a specific directory structure for go's build, package and dependency management to work correctly. Under your go workspace create the following directory structure: src/github.com/soulski. Clone the message bus and example scenario to directories under the soulski directory.

These projects use make for building the project. First you have to build the message bus but there is an issue. Go to the dmp directory where you cloned the project and issue the following command:

```
make build
```

This will fail because the project doesn't manage its dependencies correctly. At least one of the libraries has been updated so that it doesn't work with the older version of go we are using. With a newer version of Go we would run to a different problem with dependencies. Go uses git to fetch the projects' dependencies from GitHub. It downloads them under the github.com directory in your go workspace. This allows you to return the dependencies to the state they were in when this project was developed. Go to each new repository that have appeared and give the following command:

```
git checkout `git rev-list -n 1 --before="2016-06-26 00:00" master`
```

Note: there is one repository where this fails so don't worry about it.

Now the build should succeed. The code is compiled and a docker image is created from it. The makefile includes a target for starting a cluster of message bus instances, that each run in a separate dokcer container,  using docker compose. They run in a docker network with specific ip addresses which you have to create:

```
docker network create --subnet 173.17.0.0/16 --gateway 173.17.0.1 dmp
```

Now you can start the message bus cluster:

```
make cluster-up
```

You can stop it with:

```
make cluster-down
```

When the cluster is running you can see if its working correctly by checking log of docker compose which has the output from each container:

```
docker-compose logs
```

The log should show how the message bus instances are first finding each other and then exchanging information between them. Include a part of this log in your reply for this task (no screenshot, direct the output of the command into a file).

After getting the message bus itself compiled and working you can build the example scenario in the dmp-scenario directory. Its build and deployment systems are similar to the message bus itself. When you get it working its web interface is available at http://localhost:8080 (or for your virtual machine host at the VM's ip addres port 8080). From the interface you can see the IP addresses of the different message bus instances. They are listening on port 8080. Get a list of the cluster members in the JSON format from one of them with a HTTP request to its public api (see the paper for how to get the memberlist). Include the response you got to your report for this task.

### Report

Apart from the items mentioned above your response to this task doesn't have to contain much. You can shortly report how everything went and did you encounter any problems. If you did not get everything working explain what was the problem and how did you try to solve it. You can also contact me for help though I don't guarantee that I  can help.

## Task 2

The second task is to implement a simple "microservice" that uses the message bus. The application can be very simple hello worl type application. It is enough that you have two services that some how communicate via the message bus. You can use any message style (request / response, publish / subscribe or notification). It is enough that one service sends something to the other via the message bus. Your application doesn't even have to have a public interface.

You can use any programming language and framework. This repository contains a node.js application template in the nodejs-template directory that you can use. See its readme for details. Your application should be similar to the example scenario meaning that each service instance should have its own message bus instance. I recommend using docker and docker compose but it might be possible to do this without thougth I have not tried. Even if you are not going to use the node.js template you might want to take a look at it to see how to use the message bus and a service inside docker.
See the paper for details how to use the message bus. Note the paper has an error when it shows how to register a service. The JSON should have a key named contact-point not contactPoint.

Your response to this task should include your code (zip package or link to a public git repository). Include also a readme that shortly documents you service: what it does, what messagin style it uses, how to run it ( at least when you are not using the nodejs template).

### Task 3

The third task is a literature based one. The related work section of the paper introduces three similar systems to the one presented in the paper. The task is to choose one of them and compare it to the message bus presented in the paper. Your response should contain:

- introduction of the system you chose
- how the authors of the paper have compared your chosen system to their message bus
- your thoughts about their comparison : agree / disagree
- possibly additional comparison by you (did the paper authors miss something)

The idea here is not just to read the related work section of the message bus paper but to take a look at the papers that describe the related work.
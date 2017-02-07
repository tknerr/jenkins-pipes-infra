
# Minimal Jenkins Pipeline a la Travis-CI Setup

This is meant to be a minimal example showing how to set up Jenkins with [Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) to support the following scenario:

 * all jobs are under version control and automatically created via Job DSL
 * each source code repository defines its build pipeline via `Jenkinsfile`
 * feature branch builds are supported out of the box

## Run It

Create the docker image and run it, with port 8080 forwarded to the host:

```
$ docker build -t jenkins-pipes .
$ docker run -it --rm -p 8080:8080 jenkins-pipes
```

Once Jenkins is started you should see your jobs up and running:
http://localhost:8080

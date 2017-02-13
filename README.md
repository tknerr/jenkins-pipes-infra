
# Jenkins Pipes Infrastructure

This is meant to be a minimal example showing how to set up Jenkins 2.x with the [Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) to support the following scenario:

 * all jobs are under version control and described via [Job-DSL](https://github.com/jenkinsci/job-dsl-plugin/wiki), see the [jenkins-pipes-jobs](https://github.com/tknerr/jenkins-pipes-jobs) repo
 * there is a [seed-job](https://github.com/tknerr/jenkins-pipes-infra/blob/master/seedJob.xml) which runs periodically to ensure the aforementioned jobs exist in Jenkins
 * each project to be built by these jobs defines its own build pipeline via [Pipeline-DSL](https://jenkins.io/doc/book/pipeline/syntax/) in a `Jenkinsfile`, see the  [jenkins-pipes-helloworld](https://github.com/tknerr/jenkins-pipes-helloworld) example


## Run It

Create the docker image and run it, with port 8080 forwarded to the host:

```
$ docker build -t jenkins-pipes .
$ docker run -it --rm -p 8080:8080 jenkins-pipes
```

Once Jenkins is started you should see at least the seed-job on [http://localhost:8080](http://localhost:8080).

If it has not run yet, simply trigger it and see how [the actual jobs](https://github.com/tknerr/jenkins-pipes-jobs) get created.


## How it works

It's simply a minimalized jenkins (master only) setup that is running in a docker container. Looking at the [`Dockerfile`](https://github.com/tknerr/jenkins-pipes-infra/blob/master/Dockerfile) you can see that all it does is:

 * inherits from the official [`jenkins:2.32.2`](https://hub.docker.com/r/library/jenkins/) image
 * skips the setup wizard and leaves jenkins unsecured
 * installs the minimum necessary `job-dsl`, `git` and `workflow-aggregator` plugins
 * copies the [`seedJob.xml`](https://github.com/tknerr/jenkins-pipes-infra/blob/master/seedJob.xml) to the Jenkins jobs directory

Optionally, you can pass the `--build-args jobs_repo=...` parameter to configure the seed job with your own jobs repository.


## Where to go from here?

Now that you have a basic setup running, there are a few things to explore next:

 * create your own jobs repo and pass it via `--build-args` to to the `docker build` command
 * use docker-compose to set up the Jenkins master with a build slave that can build projects with your toolchain of choice (e.g. java / maven)
 * create a new hello world example for the toolchain of your choice and make sure it builds on your new build slave
 * ...

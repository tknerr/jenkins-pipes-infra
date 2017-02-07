
# Jenkins Pipes

This is meant to be a minimal example showing how to set up Jenkins 2.x with the [Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) to support the following scenario:

 * all jobs are under version control and described via [Job-DSL](https://github.com/jenkinsci/job-dsl-plugin/wiki), see the [jenkins-pipes-jobs](https://github.com/tknerr/jenkins-pipes-jobs) repo
 * there is a [seed-job](https://github.com/tknerr/jenkins-pipes-infra/blob/master/seedJob.xml) which runs periodically to ensure the aforementioned jobs exist in Jenkins
 * each project to be built by these jobs defines its own pipeline via [Pipeline-DSL](https://jenkins.io/doc/book/pipeline/syntax/) in a `Jenkinsfile`, see the  [jenkins-pipes-helloworld](https://github.com/tknerr/jenkins-pipes-helloworld) example


## Run It

Create the docker image and run it, with port 8080 forwarded to the host:

```
$ docker build -t jenkins-pipes .
$ docker run -it --rm -p 8080:8080 jenkins-pipes
```

Once Jenkins is started you should see at least the seed-job:
http://localhost:8080

If it has not run yet, simply trigger it and see how the actual jobs get created.

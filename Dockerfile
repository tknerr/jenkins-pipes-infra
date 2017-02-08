FROM jenkins:2.32.2

# skip the setup wizard
ENV JAVA_ARGS -Djenkins.install.runSetupWizard=false
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# install minimum set of plugins
RUN install-plugins.sh \
  job-dsl:1.57 \
  git:3.0.1 \
  workflow-aggregator:2.5

# create the seed job which spawns all other jobs
RUN mkdir -p /usr/share/jenkins/ref/jobs/seed-job
COPY seedJob.xml /usr/share/jenkins/ref/jobs/seed-job/config.xml

# allow to pass in the jobs repo as a --build-arg
ARG jobs_repo=https://github.com/tknerr/jenkins-pipes-jobs.git
RUN sed -i "s!__JOBS_REPO__!$jobs_repo!" /usr/share/jenkins/ref/jobs/seed-job/config.xml

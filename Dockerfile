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


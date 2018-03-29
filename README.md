# Jenkins Image

[![Build Status](https://travis-ci.org/buildit/jenkins-image.svg?branch=master)](https://travis-ci.org/buildit/jenkins-image)
[![Docker Pulls](https://img.shields.io/docker/pulls/builditdigital/jenkins-image.svg)](https://hub.docker.com/r/builditdigital/jenkins-image/)


This repostory builds an image containing the Buildit [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) and [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner). Both these components use the [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) to fetch their configuration. Follow the link to the [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) for instructions on how to configure the config location.

The entrypoint of the image launches the [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) to download a Jenkins War file at startup (see [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) for a configuration sample) and has a version of the [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) baked into the $JENKINS_HOME/init.groovy.d directory (see the [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) for instructions on how to configure a set of startup scripts). 

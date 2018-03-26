# Jenkins Image

[![Build Status](https://travis-ci.org/buildit/jenkins-image.svg?branch=master)](https://travis-ci.org/buildit/jenkins-image)

This repostory builds an image containing the Buildit [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) and [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner). The latest image can be pulled directly from Docker Hub - https://hub.docker.com/r/builditdigital/jenkins-image/.

The entrypoint of the image launches the [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) to download a Jenkins War file at startup (see [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) for configuration sample) and has a version of the [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) baked into the $JENKINS_HOME/init.groovy.d directory.

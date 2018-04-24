# Jenkins Image

[![Build Status](https://travis-ci.org/buildit/jenkins-image.svg?branch=master)](https://travis-ci.org/buildit/jenkins-image)
[![Docker Pulls](https://img.shields.io/docker/pulls/builditdigital/jenkins-image.svg)](https://hub.docker.com/r/builditdigital/jenkins-image/)


This repostory builds an image containing the Buildit [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) and [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner). Both these components use the [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) to fetch their configuration. Follow the link to the [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) for instructions on how to configure the config location.

The entrypoint of the image launches the [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) to download a Jenkins War file at startup (see [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) for a configuration sample) and has a version of the [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) baked into the $JENKINS_HOME/init.groovy.d directory (see the [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) for instructions on how to configure a set of startup scripts). 

## How It Works

1. [Jenkins Fetcher](https://github.com/buildit/jenkins-fetcher) uses [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) to get config in order to determine the jenkins war file to download.
2. Once the war file is available, it is initiated using the “java -jar” command.
3. The [Jenkins Startup Scripts Runner](https://github.com/buildit/jenkins-startup-scripts-runner) is baked into the $JENKINS_HOME/init.groovy.d directory. As such it will be kicked off during the initialisation phase (see https://wiki.jenkins.io/display/JENKINS/Groovy+Hook+Script for more details).
4. The runner again uses the [Jenkins Config Fetcher](https://github.com/buildit/jenkins-config-fetcher) to get the config to determine which [Jenkins Startup Scripts](https://github.com/buildit/jenkins-startup-scripts) archive to download and run.
5. Once downloaded, the archive is unpacked and executed by kicking of the main method of the main.groovy file located in the root of the exploded archive.
6. The main method loops round the list of scripts it has in its configuration, executing each one for which it has a corresponding config section available (e.g. the mail.groovy file is only executed if “config?.mail” evaluates to a non null value).

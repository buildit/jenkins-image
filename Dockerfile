FROM openjdk:8-jdk

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG jenkins_home=/var/jenkins
ARG jenkins_fetcher_home=/var/jenkins-fetcher
ARG jenkins_fetcher_version=2.3.0
ARG jenkins_runner_version=2.5.0
ARG repository=https://dl.bintray.com/buildit/maven

# Add build.properties file
ADD gradle.properties build.properties

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -d ${jenkins_home} -u ${uid} -g ${gid} -m -s /bin/bash ${user}

ENV JENKINS_HOME ${jenkins_home}
RUN chown -R ${user} ${jenkins_home}

ENV JENKINS_FETCHER_HOME ${jenkins_fetcher_home}
RUN mkdir ${jenkins_fetcher_home} && chown -R ${user} ${jenkins_fetcher_home}

USER root

RUN apt-get update && apt-get install -y \
    git \
    vim \
    sudo \
    nano \
    net-tools \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && echo "${user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
# Download the jenkins-startup-scripts-runner
RUN curl -SLO -k ${repository}/com/buildit/jenkins/jenkins-startup-scripts-runner/${jenkins_runner_version}/jenkins-startup-scripts-runner-${jenkins_runner_version}.zip \
  && mkdir ${jenkins_home}/init.groovy.d \
  && unzip jenkins-startup-scripts-runner-${jenkins_runner_version}.zip -d ${jenkins_home}/init.groovy.d

# Download the jenkins-fetcher
RUN curl -SLO -k ${repository}/com/buildit/jenkins/jenkins-fetcher/${jenkins_fetcher_version}/jenkins-fetcher-${jenkins_fetcher_version}.zip \
  && unzip jenkins-fetcher-${jenkins_fetcher_version}.zip -d ${jenkins_fetcher_home}


# for main web interface:
EXPOSE ${http_port}

# will be used by attached slave agents:
EXPOSE ${agent_port}

COPY start.sh ${jenkins_fetcher_home}/start.sh
RUN chmod +x ${jenkins_fetcher_home}/start.sh

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
# Note. Keep this at end of this file - otherwise the init.groovy.d contents will disappear
VOLUME ${jenkins_home}

USER ${user}

ENTRYPOINT ["/bin/bash", "-c", "/var/jenkins-fetcher/start.sh"]


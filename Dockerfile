FROM siutin/ubuntu-rails-apache-passenger:latest
MAINTAINER Martin Chan <osiutino@gmail.com>
ENV REFRESHED_AT 2015-04-03

USER root

RUN apt-get update
RUN apt-get -y install openssh-client openssh-server
RUN apt-get -y install git-core

# -----------------------------------------------------------

RUN touch /etc/ssh/ssh_host_rsa_key
RUN echo 'sudo service ssh start' >> /etc/bash.bashrc
RUN service ssh start

# -----------------------------------------------------------
RUN mkdir /home/worker/.ssh
ADD ssh/* /home/worker/.ssh/
RUN chmod 755 /home/worker/.ssh
RUN chmod 400 /home/worker/.ssh/id_rsa
RUN chown -R worker:worker /home/worker/.ssh
# -----------------------------------------------------------

USER worker
WORKDIR /home/worker/


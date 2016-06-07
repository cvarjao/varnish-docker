# Must use URL
FROM registry.access.redhat.com/rhel7
MAINTAINER cleciovarjao@gmail.com

ENV GOGS_CUSTOM /home/gogs

#Install core tools
RUN yum install -y curl tar sudo cronie && \
    sed -i '/Defaults    requiretty/s/^/#/' /etc/sudoers && \
    yum clean all -y

#Install gosu    
ADD https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64 /usr/local/bin/gosu
ADD https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64.asc /usr/local/bin/gosu.asc
RUN chmod +x /usr/local/bin/gosu

#Install s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" --exclude="./sbin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin ./sbin && \
    rm -f  /tmp/s6-overlay-amd64.tar.gz

RUN useradd -Um docker

EXPOSE 80
WORKDIR /home/docker
#VOLUME ["/data"]

ENTRYPOINT ["top", "-b"]

FROM centos:latest

MAINTAINER eduardz

# Install apache
RUN yum install httpd -y

# Chaperone install #
RUN yum -y install epel-release; \
    yum -y install python34; \
    curl -s "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"; \
    python3.4 get-pip.py; \
    rm get-pip.py

# Set symlink
RUN cd /usr/bin; ln -s python3.4 python3

# Chaperone
RUN pip3 install chaperone; mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf
COPY httpd.conf /etc/httpd/conf/

# Clean docker image
RUN yum clean all; rm -rf /tmp/* /var/tmp/*

# Apache
RUN chown -R apache:apache /var/log /etc/httpd /run/httpd

EXPOSE 8080

# Chaperone start
ENTRYPOINT ["/usr/bin/chaperone"]

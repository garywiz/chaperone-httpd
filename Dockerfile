FROM centos:latest

MAINTAINER eduardz

# Install apache
RUN yum install httpd -y

# Chaperone install #
RUN yum -y install epel-release
RUN yum -y install python34
RUN curl -s "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python3.4 get-pip.py

# Set symlink
RUN cd /usr/bin
RUN ln -s python3.4 python3

# Chaperone
RUN pip3 install chaperone
RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf

# Clean docker image
RUN yum clean all
RUN rm -rf /tmp/* /var/tmp/*

# Apache
RUN chown -R apache:apache /var/log /etc/httpd
EXPOSE 80

# Chaperone start
ENTRYPOINT ["/usr/bin/chaperone"]

# Run as user
#USER apache ---under work

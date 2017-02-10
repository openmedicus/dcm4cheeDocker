FROM centos:7
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

# install http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm

# Update
RUN yum -y update

# Clean yum
RUN yum -y install unzip

# install Java
ADD jdk-8u121-linux-x64.rpm /
RUN yum -y install jdk-8u121-linux-x64.rpm 

# install DCM4CHEE
RUN mkdir -p /opt/dcm4che
ADD dcm4chee-2.18.3-psql.zip /
RUN unzip -q dcm4chee-2.18.3-psql.zip && mv /dcm4chee-2.18.3-psql /opt/dcm4che/dcm4chee 

# Cleanuo
RUN yum clean all
RUN rm -f jdk-8u121-linux-x64.rpm dcm4chee-2.18.3-psql.zip 


EXPOSE 8080 11112

# By default, simply start apache.
CMD /opt/dcm4che/dcm4chee/bin/run.sh


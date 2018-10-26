FROM registry.access.redhat.com/rhel7/rhel
RUN subscription-manager register --username deepika.thimmegowda-cic-uk@ibm.com --password Logintowork@123 --auto-attach

ENV SBT_VERSION 0.13.13

# Install Java8 
RUN yum install -y java-1.8.0-openjdk-devel

RUN yum install -y https://dl.bintray.com/sbt/rpm/sbt-0.13.13.rpm

RUN yum install -y unzip

WORKDIR /HelloWorld

ADD . /HelloWorld

RUN sbt dist

RUN set -x 

RUN unzip -d svc target/universal/*-1.0-SNAPSHOT.zip 

RUN mv /HelloWorld/svc/*/* /HelloWorld/svc/ 

RUN rm /HelloWorld/svc/bin/*.bat 

RUN mv /HelloWorld/svc/bin/* /HelloWorld/svc/bin/start


EXPOSE 9000 9443

CMD /HelloWorld/svc/bin/start -Dhttps.port=9443 -Dplay.crypto.secret=secret
#
# Scala and sbt Dockerfile
#
# https://github.com/mhandl/scala-sbt
#

# Pull base image
FROM mhandl/artin_base:latest

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.13

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc


# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get install -y sbt


# create an empty sbt project;
# then fetch all sbt jars from Maven repo so that your sbt will be ready to be used when you launch the image
COPY init-sbt.sh /tmp/

RUN cd /tmp  && ./init-sbt.sh  && rm -rf *

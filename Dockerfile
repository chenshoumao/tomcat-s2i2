# tomcat-s2i22
FROM maven:3.3-jdk-7
# TODO: Put the maintainer name in the image metadata
MAINTAINER chenshoumao
# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0
#TODO: Set labels used in OpenShift to describe the builder image
LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.k8s.description="Tomcat S2I Builder" \
      io.k8s.display-name="tomcat s2ii builder 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,tomcat"
WORKDIR /opt
ADD ./apache-tomcat-8.5.43.tar.gz /opt
RUN useradd -m tomcat -u 1001 && \
chmod -R a+rw /opt && \
chmod a+rwx /opt/apache-tomcat-8.5.43/* && \
chmod +x /opt/apache-tomcat-8.5.43/bin/*.sh && \
rm -rf /opt/apache-tomcat-8.5.43/webapps/*
# TODO: Copy the S2I scripts to /usr/libexec/s2i, since maven:3.3-jdk-7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i
# This default user is created in the image
USER 1001
# TODO: Set the default port for applications built using this image
EXPOSE 8080
ENTRYPOINT []
# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]

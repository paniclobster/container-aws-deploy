# Entrypoint image
FROM docker:20.10.17 AS docker

# Base image
FROM amazon/aws-cli:2.7.23

# Base dependencies
RUN yum update --assumeyes && yum install --assumeyes \
    git \
    openssh \
    zip \
  && amazon-linux-extras install -y \
    docker \
  && yum clean all \
  && rm -rf /var/cache/yum

# Entrypoint
COPY --from=docker /usr/local/bin/docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]

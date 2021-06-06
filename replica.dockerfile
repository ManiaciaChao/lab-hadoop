FROM local/c7-systemd as instance
WORKDIR /src
COPY . .
# RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install openssh openssh-server openssh-clients java-1.8.0-openjdk
RUN bash ./scripts/init.sh
# CMD ["systemctl","start","sshd"]
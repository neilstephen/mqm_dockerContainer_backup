FROM centos:6.7

MAINTAINER Neil Wood <neil.wood@waterstones.com>
# currently in development

#copy rpm's, system files, copied from the original mta
COPY rpms_and_MQS /opt
COPY systemfiles/sysctl.conf /etc
COPY systemfiles/limits.conf /etc/security/limits.conf
COPY systemfiles/mqmcron /var/spool/cron/mqm

# Install dependencies and usefull stuff. Note centos 6.7 comes with python 2.6.6 already
RUN \
  yum update -y && \
  yum install -y yum-utils wget telnet patch tar bzip2 unzip openssl-devel openssh-clients rsync epel-release && \
  yum install -y \
    vim \
    bc \
    git \
    gcc \
    python-pip \
    passwd \
    cronie && \
  pip install ebcdic && \
  yum install -y libxslt-devel libxml2-devel && \
  yum install -y python-devel && \
  yum clean all && rm -rf /tmp/*

RUN \
  groupadd mqm && useradd -g mqm mqm && \
  ulimit -u && \
  cd /opt && tar -xzvf WMQ_7.1.0.3_TRIAL_LNX_X86_64_ML.tar.gz && \
  cd /opt && ./mqlicense.sh -accept -text_only && \
  cd /opt && rpm -ivh /opt/MQSeriesRuntime-7.1.0-3.x86_64.rpm && \
  rpm -ivh MQSeriesJRE-7.1.0-3.x86_64.rpm && \ 
  rpm -ivh MQSeriesServer-7.1.0-3.x86_64.rpm && \ 
  rpm -ivh MQSeriesJava-7.1.0-3.x86_64.rpm && \ 
  rpm -ivh MQSeriesSamples-7.1.0-3.x86_64.rpm && \ 
  rpm -ivh MQSeriesClient-7.1.0-3.x86_64.rpm && \
  rpm -ivh MQSeriesSDK-7.1.0-3.x86_64.rpm && \
  pip install phpserialize && \
  yum install -y mysql-connector-python-1.1.6-1.el6.noarch php-mysql-5.3.3-48.el6_8.x86_64 && \
  yum install -y mysql-connector-odbc-5.1.5r1144-7.el6.x86_64 mysql-libs-5.1.73-7.el6.x86_64 mysql-server-5.1.73-7.el6.x86_64

# setup cron and ifs
RUN chmod 0744 /var/spool/cron/mqm && \
    chown mqm:mqm /var/spool/cron/mqm && \
    mkdir /var/ifsmq
#COPY var-ifsmq /var/ifsmq

# Expose ports for mqm
EXPOSE 1414

# start.sh script runs on system start, will set linux system limits, setup MQSeries and ifs bridge.
COPY start.sh /start.sh
COPY mqm_home_dir_files /home/mqm
COPY slash-root /root

ENTRYPOINT bash -C '/start.sh';'/bin/bash'

# Current Docker Build/Run commands while in development.
# docker build -t mta . 2>&1 |tee out.log
# docker run --privileged=true -p 1414:1414 -t -i mta
# docker exec -it <ID> /bin/bash, if you need to enter the container, the ID can be obtainened from running docker ps.
# passwd can be removed from the Run command when in production.

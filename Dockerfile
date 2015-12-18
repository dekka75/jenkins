FROM centos:6.6

MAINTAINER KIMES Didier <didier.kimes@orange.com>

# UPDATE OS
RUN yum -y update

# TOOLS
RUN yum -y install curl git wget unzip tar which bzip2
	
# Java 1.7.0
RUN yum -y install java-1.7.0-openjdk.x86_64

# PHP
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
RUN yum install -y php55w php55w-bcmath php55w-gd php55w-intl php55w-mbstring \
                   php55w-mcrypt php55w-mysql php55w-opcache php55w-pdo php55w-pear php55w-pecl-memcache \
                   php55w-soap php55w-xml php55w-cli

# TOMCAT & JENKINS
RUN mkdir -p /data; \
	cd /data; \
	curl -Lo apache-tomcat-8.0.30.tar.gz http://apache.crihan.fr/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz; \
	tar -xvzf apache-tomcat-8.0.30.tar.gz; \
	mv apache-tomcat-8.0.30 tomcat8; \
	rm apache-tomcat-8.0.30.tar.gz
RUN cd /data/tomcat8/webapps/; \
	curl -Lo jenkins.war http://mirrors.jenkins-ci.org/war/latest/jenkins.war
ADD server.xml /data/tomcat8/conf/server.xml
ADD tomcat8 /etc/init.d/tomcat8
RUN chmod +x /etc/init.d/tomcat8
ADD tomcat-users.xml /data/tomcat8/conf/tomcat-users.xml
	
# COMPOSER
ADD composer.json /data/composer/composer.json
RUN mkdir -p /data/composer; \
    cd /data/composer; \
    curl -sS https://getcomposer.org/installer | php; \ 
    php composer.phar self-update; \
    php composer.phar install --prefer-source

# NODEJS & PHANTOMJS
RUN cd /data/composer; \
	curl --silent --location https://rpm.nodesource.com/setup | bash -; \
	yum install -y nodejs npm; \
	npm install npm -g; \
	npm install -g csslint; \
	npm install -g phantomjs; \
	npm install -g jshint

RUN yum clean all

ENV JENKINS_HOME /data/jenkins

EXPOSE 4444

#CMD /data/tomcat8/bin/catalina.sh run

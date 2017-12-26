#FROM inspiredgeek/redmine-alpine
FROM redmine
#FROM alpine-redmine
MAINTAINER hodorii@gmail.com

ENV RAILS_ENV production
#ENV REDMINE_NO_DB_MIGRATE false

# # #speedup
RUN cd /etc/apt && \
     sed -i 's/deb.debian.org/ftp.harukasan.org/g' sources.list; \
	apt-get update && apt-get install -y curl git mercurial subversion graphviz openjdk-7-jre build-essential 
#RUN apk --no-cache add --virtual .run-deps graphviz subversion mercurial openjdk8 git curl
ENV HOME /usr/src/redmine
ADD prepare_plugins.sh .
RUN bash prepare_plugins.sh
#ADD plugins plugins/
#RUN echo '#!/bin/bash' >> plugins/plantuml/plantuml
#RUN echo 'java -cp /usr/src/redmine/plugins/plantuml/. -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/src/redmine/plugins/plantuml/plantuml.jar ${@}' >> plugins/plantuml/plantuml
#RUN chmod a+x plugins/plantuml/plantuml

ENV LANG C.UTF-8
ADD SeoulHangangB.ttf /usr/share/fonts/
ADD NanumGothicBold.ttf /usr/share/fonts/
RUN fc-cache -f -v

RUN \
	for adapter in sqlite3; do \
		echo "$RAILS_ENV:" > ./config/database.yml; \
		echo "  adapter: $adapter" >> ./config/database.yml;\
		bundle update ; \
		bundle install --without development test; \
	done & rm config/database.yml;
RUN 	apt-get autoremove build-essential; \
        rm -rf /root/* `gem env gemdir`/cache /var/lib/apt/lists/*;

# RUN sed -i 's/A/B/' targetfile

VOLUME /usr/src/redmine/files
VOLUME /usr/src/redmine/sqlite

EXPOSE 3000
#		sed -i 's/4\.3\.1/4\.3\.4/' Gemfile.lock;\
		#gem install haml htmlentities ;\

FROM inspiredgeek/redmine-alpine
#FROM redmine
MAINTAINER hodorii@gmail.com

ENV RAILS_ENV production
ENV HOME /usr/src/redmine
#ENV REDMINE_NO_DB_MIGRATE false

# # #speedup
  # RUN cd /etc/apt && \
  #     sed -i 's/archive.ubuntu.com/ftp.daum.net/g' sources.list; \
  #   apt-get update && apt-get install -y git mercurial subversion
RUN  apk --no-cache add --virtual .run-deps git subversion mercurial graphviz openssl openjdk7

WORKDIR /usr/src/redmine/plugins

#scrum ( https://redmine.ociotec.com/projects/redmine-plugin-scrum )
# RUN wget -O scrum.tar.gz https://redmine.ociotec.com/attachments/download/440/scrum%20v0.16.2.tar.gz \
#  	&& tar xvf scrum*
ADD scrum*tar.gz ./

#jenkins
RUN git clone https://github.com/jbox-web/redmine_bootstrap_kit.git;cd redmine_bootstrap_kit;git checkout 0.2.3
RUN git clone https://github.com/jbox-web/redmine_jenkins.git;cd redmine_jenkins; git checkout 1.0.1

# code review
RUN hg clone https://bitbucket.org/haru_iida/redmine_code_review

# clipboard_image_paste
RUN git clone https://github.com/peclik/clipboard_image_paste.git

# excel
RUN git clone https://github.com/two-pack/redmine_xls_export.git redmine_xls_export
RUN git clone https://github.com/javiferrer/redmine_import_issues.git

#pivottable
RUN git clone https://github.com/deecay/redmine_pivot_table.git

# wiki html util ( https://github.com/mexitek/redmine_wiki_html_util ) {{html() }
RUN git clone git://github.com/mexitek/redmine_wiki_html_util.git

# graphviz
#RUN apt-get install -y graphviz
RUN git clone git://github.com/tckz/redmine-wiki_graphviz_plugin.git wiki_graphviz_plugin
ADD NanumBarunGothic.ttf /usr/share/fonts/
ADD SeoulNamsanEB.ttf /usr/share/fonts/
RUN fc-cache -f -v

# plantuml
# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
RUN git clone https://github.com/dkd/plantuml.git
RUN sed -i 's/requires_redmine.*/requires_redmine :version_or_higher => "2.6"/' plantuml/init.rb
RUN wget -O plantuml/plantuml.jar http://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar
RUN cd plantuml;wget https://dl.dropboxusercontent.com/u/13064071/plantuml-jlatexmath.zip;unzip plantuml-jlatexmath.zip;rm plantuml-jlatexmath.zip
RUN mkdir -p plantuml/bin && echo '#!/bin/bash' >> plantuml/bin/plantuml
RUN echo 'java -cp /usr/src/redmine/plugins/plantuml/. -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/src/redmine/plugins/plantuml/plantuml.jar ${@}' >> plantuml/bin/plantuml
RUN chmod a+x plantuml/bin/plantuml

RUN wget -O gist.tar.gz https://github.com/dergachev/redmine_gist/archive/master.tar.gz;tar -zvxf gist.tar.gz;rm gist.tar.gz;mv redmine_gist-master redmine_gist

#RUN git clone https://github.com/stgeneral/redmine-progressive-projects-list.git progressive_projects_list

#redmine_tweak
RUN wget https://github.com/alexandermeindl/redmine_tweaks/archive/master.tar.gz -O redmine_tweaks.tar.gz - ; tar -zvxf redmine_tweaks.tar.gz;rm redmine_tweaks.tar.gz; mv redmine_tweaks-master redmine_tweaks

RUN wget -O localizable.tar.gz https://redmine.ociotec.com/attachments/download/330/localizable%200.4.0.tar.gz; tar -zxvf local*; rm *.gz;mv localizable* localizable

RUN git clone https://github.com/mrcage/wiking

WORKDIR /usr/src/redmine

RUN for adapter in sqlite3; do \
		echo "$RAILS_ENV:" > ./config/database.yml; \
		echo "  adapter: $adapter" >> ./config/database.yml;\
    gem install htmlentities -v '4.3.4'; \
		bundle install --without development test; \
	done \
  && rm ./config/database.yml
# RUN sed -i 's/A/B/' targetfile

VOLUME /usr/src/redmine/files
VOLUME /usr/src/redmine/sqlite

EXPOSE 3000

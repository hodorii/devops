FROM alpine
MAINTAINER hodorii@gmail.com
ENV BRANCH_NAME=master \
        RAILS_ENV=production
WORKDIR /usr/src/redmine
RUN addgroup -S redmine \
        && adduser -S -G redmine redmine \
	&& apk --no-cache add --virtual .run-deps \
                mariadb-client-libs \
		sqlite-libs \
                imagemagick \
                tzdata \
                ruby \
		ruby-bigdecimal \
		ruby-bundler \
                tini \
                su-exec \
                bash \
        && apk --no-cache add --virtual .build-deps \
                build-base \
                ruby-dev \
                libxslt-dev \
                imagemagick-dev \
                mariadb-dev \
                sqlite-dev \
                linux-headers \
                patch \
                coreutils \
                curl \
                git subversion mercurial\
		            graphviz\
	&& git clone -b ${BRANCH_NAME} https://github.com/redmine/redmine.git . \
        && rm -rf files/delete.me log/delete.me .git test\
        && mkdir -p tmp/pdf public/plugin_assets \
        && echo 'gem: --no-document' > /etc/gemrc \
        && gem update --system \
        && chown -R redmine:redmine ./
ADD prepare_plugins.sh .
ADD plugins ./plugins/
RUN ls -l plugins/
RUN	for adapter in mysql2 sqlite3; do \
		echo "$RAILS_ENV:" > ./config/database.yml; \
		echo "  adapter: $adapter" >> ./config/database.yml; \
    bundle update; \
		bundle install --without development test; \
	done \
	&& rm ./config/database.yml \
	&& rm -rf /root/* `gem env gemdir`/cache \
        && apk --purge del .build-deps

VOLUME /usr/src/redmine/files

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

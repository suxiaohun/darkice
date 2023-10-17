FROM 10.4.243.51:5000/ruby:3.2.2

WORKDIR /darkice

RUN gem install bundler -v '2.4.20' && gem update --system 3.4.20

COPY Gemfile Gemfile.lock /darkice/

RUN bundle install

ENV RAILS_LOG_TO_STDOUT=true
ENV MYSQL_URL="mysql.component"
ENV MYSQL_PORT=3306
ENV REDIS_URL="redis://:123456@redis-default.component:6379/1"
ENV MYSQL_PASSWORD=123456


COPY ./ /darkice

CMD ["rails","s","-b","0.0.0.0","-e","production"]


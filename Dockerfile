FROM xiaopang.base:v1.2

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN bundle config --global frozen 1

WORKDIR /var/www/xiaopang

COPY Gemfile ./

RUN bundle install

COPY . .

CMD ["rails", "s", "-e", "production"]
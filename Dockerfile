FROM 10.4.243.51:5000/ruby:3.2.2

WORKDIR /darkice

RUN gem install bundler -v '2.4.20' && gem update --system 3.4.20

COPY Gemfile Gemfile.lock /darkice/

RUN bundle install

COPY ./ /darkice

CMD ["rails","s","-b","0.0.0.0"]


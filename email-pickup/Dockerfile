FROM ruby:3.1

COPY ./ /app

WORKDIR /app

RUN gem install webrick

EXPOSE 3001

CMD [ "ruby", "app.rb" ]
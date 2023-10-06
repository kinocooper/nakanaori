# rubyのベースイメージをもとにイメージを作成
# githubからソース落としてきてること前提
FROM ruby:2.7

RUN apt-get update -qq \
&& apt-get install -y nodejs npm \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn

WORKDIR /myapp
COPY Gemfile ./
RUN bundle install
COPY . .
RUN yarn install \
&& gem install bundler:1.17.3 \
&& bundle install

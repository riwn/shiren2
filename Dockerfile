# 作成するDockerイメージのベースとなるイメージを指定
FROM ruby:2.4.4

# Dockerイメージビルド時に、Dockerコンテナ内で実行するコマンドを定義
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs less
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
RUN mkdir /shiren2
# Dockerfileをもとに生成したDockerコンテナ内で使える環境変数を指定
ENV APP_ROOT /shiren2
WORKDIR $APP_ROOT

# ホストからGemfileをコンテナ上にコピー
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileをbundle install:2.0.2
RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT

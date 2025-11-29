FROM ruby:3.3.9-slim

# 必要なパッケージを追加
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    default-libmysqlclient-dev \
    libyaml-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# entrypoint.shの改行コードを修正し、実行権限を付与
RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

CMD ["rails", "server", "-b", "0.0.0.0"]
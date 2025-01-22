# ベースイメージ
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    postgresql-client \
    vim \
    cron \
    --no-install-recommends

# 作業ディレクトリを作成
RUN mkdir /app
WORKDIR /app

# ローカルのGemfileとGemfile.lockをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# 依存関係のインストール
RUN bundle install

# アプリケーションコードをコピー
COPY . /app

# start.sh をコピー
COPY start.sh /usr/bin/start.sh

# start.sh に実行権限を付与
RUN chmod +x /usr/bin/start.sh

# cron のログを保存するディレクトリを作成
RUN mkdir -p /var/log/cron

# ポートを公開
EXPOSE 3000

# start.sh を実行
CMD ["/usr/bin/start.sh"]

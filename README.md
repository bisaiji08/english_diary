■サービス概要

日本語日記を習慣化するための育成・箱庭ゲーム。
日記を書くことで木が段階的に成長し、書いた日記を英語化することでポイントが受け取られる。溜まったポイントは、日記の装飾やフォントなどと交換ができる。
48時間以上日記を読んだら木が1段階前の状態に戻ってしまう。

■このサービスへの思い・作りたい理由

しかし、実際にうまく実践することができなかった。日記がアウトプットの練習になることを聞き、始めてみたが、続けることができなかった。
そこで、自分が毎日続けていることを考えたところ、育成・箱庭ゲームに毎日ログインしていることに気づいた。は、あまり苦ではなかった。そのため、日記と育成・箱庭ゲームを認めた。
さらに、英語日記にしようと思った理由は、プログラミング学習中に英語を目にする機会が多くなったのです。考えたからである。

■ユーザー層について

アウトプットの習慣を身に付けたい人
日記を書くことで、文章力や壁力が向上したり、自分の思考や感情を言葉で表現する力、相手に伝える力が鍛えられるから。
英語力をつけたい人
日記を英語化することで日常で使えるボキャブラリーを増やすことができるから。
育成・箱庭ゲームが好きな人
育成・箱庭ゲームを遊びながら日記を書く習慣を身につけることができるから。
■サービスの利用イメージ
毎日気軽に日記を書くことができます。
それによって、思考の言語化や、文章化能力が身につく
日記を英語化することで、日常生活で使える英語が身につく

■ユーザーの獲得について

の箱庭を自慢できるように共有機能をつける

■サービスの差別化ポイント・推しポイント

日記を書くことがおまけのような感覚になることで日記を習慣化する心構えを下げることができる。
箱庭で自分のお気に入りの場所を作ることで気軽にアプリを開きたいと考え。

■ 機能候補

MVPリリース
  会員登録・ログイン
  日記投稿
  通知機能
  ポイントを貯める
  ポイントと交換
  日記のフォント変更
  木の育成
  時間経過で木の成長が後退
  カレンダーを使って過去の日記を眺める

本リリース
  書斎の追加
  書や日記の装飾
  他のユーザーとの共有
  ガチャ

■機能の実装構想予定

認証: Devise
データベース : PostgreSQL、MongoDB
サーバーサイド: Railsのモデル
ファイルアップロード: ActiveStorage
バックグラウンドジョブ: Sidekiq、遅延ジョブ、アクティブジョブ

ポイントを貯める
  機能概要: ユーザーのアクションに応じてポイントを獲得する機能。
  使用するAPI/テクノロジー:
    データベース : PostgreSQL、MySQL
    サーバー側：Railsのモデル（ユーザー、ポイントなど）
  実装イメージ:
    ポイント管理:points_controllerを作成し、ユーザーのアクションに応じてポイントを付与するロジックを実装します。

ポイントと交換
  機能概要: 獲得したポイントを商品やサービスと交換する機能。
  使用するAPI/テクノロジー:
    データベース : PostgreSQL、MySQL
    サーバー側：Railsのモデル（Reward、PointTransactionなど）
  実装イメージ:
    ポイント交換: /api/rewardsエンドポイントを作成し、ユーザーがポイントを使用してアイテムを取得できるようにします。

日記のフォント変更
  機能概要: ユーザーが日記のフォントをカスタマイズできる機能。
  使用するAPI/テクノロジー:
    CSS: フォントスタイルを変更するためのカスタムCSS
    データベース : PostgreSQL、MySQL（ユーザーのフォント設定を保存）
  実装イメージ:
    フォント設定: user_preferences_controllerでフォント設定を管理し、application.scssで動的にフォントスタイルを変更します。

育成ゲーム要素
1 .成長ロジックの管理
  機能概要: 木の成長を管理し、ユーザーの水やりの状態に応じて木の成長段階を更新します。
  使用するAPI/テクノロジー:
    活動記録: 木の成長ステータスをデータベースで管理。
    Cron ジョブ: 成長の進行状況を定期的に更新するためのスケジューラ。
    Sidekiq または Rails Active Job: バックグラウンドジョブでの定期的なチェックと更新。
  実装イメージ:
    モデル: Treeモデルにgrowth_stage（成長段階）、last_watering_at（最後の水やりの時間）などのプロパティを追加します。
    メソッド: ツリー モデルに成長ステータスを更新するメソッドを定義。 例: update_growth_stage メソッドが水やりの状況に応じて木の段階を更新します。
    ジョブ: Sidekiq ジョブを使って、48時間ごとに木の状態を確認し、成長が戻るべきかどうかをチェックします。

2.水やりの制限管理
  機能概要: ユーザーが1日に1回だけ水やりできるように制限を設けます。
  使用するAPI/テクノロジー:
    活動記録: 水やりの履歴をデータベースで管理。
    Redis: 高速ナキー/バリューステージで水やり制限の状態を一時的に保持します（オプション）。
  実装イメージ:
    モデル: WateringLog モデルを作成し、ユーザーの水やり履歴を保存します。
    バリデーション: ユーザーが 1 日に 1 回だけ水やりできるように、コントローラ内でバリデーションを実施。 例: 最後に水やりから 24 時間以上経過していることを確認。
    キャッシュ: Redis を使用して、水やり制限の状態を一時的に保持し、高速にアクセスできるように（オプション）。

3 .木の実の収穫とリセット
  機能概要: 最大まで成長した木から実を採取し、木の成長段階をリセットします。
  使用するAPI/テクノロジー:
    現在の記録: 実の収穫や木のリセットをデータベースで管理。
    Action Cable: 任天堂の通知機能（オプション）。
  実装イメージ:
    モデル: フルーツモデルを作成し、木の実を管理。 木が最大まで成長した時にフルーツモデルのレコードを作成しました。
    リセット処理: 木から実を採取するアクションで、木の成長段階をリセットし、growth_stageを初期状態に戻します。

4 .ユーザーインターフェースと通知
  機能概要: ユーザーに水やりのタイミングや木の成長状態を通知します。
  使用するAPI/テクノロジー:
    アクションメーラー：メール通知。
    プッシュ通知: Webやモバイルアプリでのプッシュ通知（オプション、Firebase Cloud Messagingなど）。
  実装イメージ:
    通知システム: ユーザーに対して、木の水やりが可能になったことをメールや意見通知でお知らせしています。
    フロントエンド: JavaScript や AJAX を使って、ユーザーに代わって木の成長状態を表示するインターフェースを実装します。

5 .管理ツールとダッシュボード
  機能概要: 管理者が木の状態やユーザーのアクティビティを監視するためのダッシュボードを提供します。
  使用するAPI/テクノロジー:
    Rails Admin または ActiveAdmin: 管理者用のダッシュボードを簡単に構築するためのGem。
  実装イメージ:
    ダッシュボード: 管理者が木の状態やユーザーの活動を一目で確認できるダッシュボードを提供します。Rails Admin や ActiveAdmin を使用して、直感的なインターフェースを実現します。

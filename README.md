# [Gamequest](https://game-quest.net)

# アプリ概要
Gamequestはゲームで疑問に思ったことを質問できるアプリです。疑問に思ったことを聞ける掲示板としての機能や、気になる投稿をする人をフォローできるSNSとしての機能があります

ユーザー関係
- ユーザー登録(gem: devise)
- ログイン(gem: devise)
- twitterログイン(gem: omniauth-twitter)
- フォロー機能
- マイページ
- アイコン変更(gem: carrier-wave)
- プロフィール文変更
- フォロワーの投稿、自分の投稿、いいね一覧の確認

投稿関係
- テキスト投稿
- タグ生成(gem: act-as-taggable-on)
- 画像・動画投稿(gem: carrier-wave)
- 削除機能
- いいね(非同期通信化済)
- コメント作成(テキスト・画像)
- 既読機能　
- おすすめ機能
- 検索機能
- ページネーション(gem: kaminari)

# 本番環境
https://game-quest.net

ヘッダーの「ゲストログイン」をクリックすることでゲストユーザーとしてログインできます

# 基本機能
基本的な投稿、コメント、フォロー、いいね機能などを備えています。
![image](https://user-images.githubusercontent.com/65850089/111410978-1b7e5e80-871d-11eb-801f-dd97d36683c3.png)
![image](https://user-images.githubusercontent.com/65850089/111411108-52547480-871d-11eb-801b-eb43002a4969.png)

# 特徴
おすすめ機能と検索機能を独力かつライブラリ無しで実装しています

![image](https://user-images.githubusercontent.com/65850089/111411519-0e15a400-871e-11eb-90da-52c00b434265.png)

また、外部API連携としてTwitterログイン機能も実装しています。
![image](https://user-images.githubusercontent.com/65850089/111413128-086d8d80-8721-11eb-8604-65bb95f4847f.png)

# AWS構成図
AWSのECS ECR RDS Route53などを使ったデプロイを自力で調べて実装しました。
![構成図](https://user-images.githubusercontent.com/65850089/111438267-64e3a380-8747-11eb-8c3b-c35bfd43bae9.png)

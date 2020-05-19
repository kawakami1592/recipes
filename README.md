# RecipeS
男性向けのレシピサイトです。
レシピの投稿、回覧ができ、イイねを付けることでマイページで一覧表示します。
![screencapture-localhost-3000-2020-05-19-03_15_01](https://user-images.githubusercontent.com/57590363/82246129-17f43c80-997f-11ea-8cef-92cc05be28d7.png)

![screencapture-localhost-3000-recipes-16-2020-05-19-03_13_28](https://user-images.githubusercontent.com/57590363/82245940-d1064700-997e-11ea-9701-c57dc76e6ce8.png)

![screencapture-localhost-3000-users-2-2020-05-19-03_17_22](https://user-images.githubusercontent.com/57590363/82246259-4bcf6200-997f-11ea-877a-670029241cc3.png)

# 使用技術
- Haml
- SCSS
- ruby 2.5.1
- Rails 5.2.4.2
- JavaScript(jQuery)
- RSpec
- AWS

# 機能
- ユーザ登録,ログイン機能(devise)
- レシピ投稿機能
- 多階層カテゴリー(ancestry)
- 画像のプレビュー機能(jQuery)
- 複数画像アップロード(carrierwave)
- いいね機能
- 単体テスト(RSpec)
- 自動デプロイ(capistrano)

# DB設計

## Usersテーブル
|Column   | Type       | Options                  |
|email    | string     | null: false, default: "" |
|password | string     | null: false, default: "" |
|nickname | string     | null: false              |
|sex      | references | null: false              |

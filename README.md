# RecipeS
男性向けのレシピサイトです。
レシピの投稿、回覧ができ、イイねを付けることでマイページで一覧表示します。

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

# 紹介
![screencapture-localhost-3000-2020-05-19-03_15_01](https://user-images.githubusercontent.com/57590363/82246129-17f43c80-997f-11ea-8cef-92cc05be28d7.png)

![screencapture-localhost-3000-recipes-16-2020-05-19-03_13_28](https://user-images.githubusercontent.com/57590363/82245940-d1064700-997e-11ea-9701-c57dc76e6ce8.png)

![screencapture-localhost-3000-users-2-2020-05-19-03_17_22](https://user-images.githubusercontent.com/57590363/82246259-4bcf6200-997f-11ea-877a-670029241cc3.png)


# DB設計

## Usersテーブル
|Column   |Type       |Options                  |
|---------|-----------|-------------------------|
|email    |string     |null: false, default: "" |
|password |string     |null: false, default: "" |
|nickname |string     |null: false              |
|sex      |references |null: false              |

### Association
- belongs_to_active_hash :sex

## Recipesテーブル
|Column     |Type       |Options                        |
|-----------|-----------|-------------------------------|
|title      |string     |null: false                    |
|user       |references |null: false, foreign_key: true |
|category   |references |null: false                    |
|text       |text       |null: false                    |
|image      |string     |null: false                    |
|point      |text       |                               |
|difficulty |references |null: false                    |

### Association
- belongs_to :user
- belongs_to :category, optional: true
- has_many :ingredients, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :users, through: :likes
  accepts_nested_attributes_for :ingredients, allow_destroy: true
- has_many :makeds
  accepts_nested_attributes_for :makeds, allow_destroy: true

## Ingredientsテーブル
|Column     |Type       |Options                        |
|-----------|-----------|-------------------------------|
|recipe     |references |null: false, foreign_key: true |
|ingredient |string     |null: false                    |
|quantity   |string     |null: false                    |

### Association
- belongs_to :recipe

## Makedsテーブル
|Column     |Type       |Options                        |
|-----------|-----------|-------------------------------|
|recipe     |references |null: false, foreign_key: true |
|text       |text       |null: false                    |
|image      |string     |null: false                    |

### Association
- belongs_to :recipe

## Categoriesテーブル
|Column |Type   |Options |
|-------|-------|--------|
|name   |string |        |

### Association
- has_many :recipes
- has_ancestry

## Likesテーブル
|Column |Type       |Options                        |
|-------|-----------|-------------------------------|
|user   |references |null: false, foreign_key: true |
|recipe |references |null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :recipe
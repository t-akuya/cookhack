# README
<img  alt="" src="">

## アプリ名
Cookhack

## 概要
料理を時短するためのレシピ投稿サイトです。
時短料理のレパートリーや時短テクニックを共有し、料理にかかる時間を削減、楽にします。

## 本番環境
URL:

ログイン情報 
- Eメール:
- パスワード:

Basic認証
- ID:
- Pass:

## 制作背景(意図)
　誰かの課題を解決できるようなアプリを作りたいと考えていたので、まずは一番身近である家族の負担を軽減できたらと思い、制作しました。
家事の中でも料理は特に時間と労力を費やします。その負担を少しでも減らし、ユーザーの自由な時間を少しでも増やせるように設計しました。

## DEMO
	画像はGyazoGIFはGyazoGIFで


## 工夫したポイント

## 使用技術(開発環境)

## 課題や今後実装したい機能

## DB設計
ER図等を添付




## usersテーブル

| Column             | Type     | Options                       |
| ------------------ | -------- | ----------------------------- |
| nickname           | string   | null: false                   |
| email              | string   | null: false, unique: true     |
| encrypted_password | string   | null: false                   |
| first_name         | string   | null: false                   |
| last_name          | string   | null: false                   |
| first_name_kana    | string   | null: false                   |
| last_name_kana     | string   | null: false                   |
| birth_day          | date     | null: false                   |

### Association
- has_many :repertoires
- has_many :ingredients
- has_many :cooking_hack



## cooking_hack

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| title              | string     | null: false                   |
| summary            | text       | null: false                   |
| process            | text       | null: false                   |
| user               | references | null: false                   |

### Association
- belongs_to :user



## repertoiresテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| cooking_time_id    | integer    | null: false                   |
| recipe             | text       | null: false                   |
| comment            | text       | null: false                   |
| category_id        | integer    | null: false                   |
| serving_id         | integer    | null: false                   |
| user               | references | null: false, foreign_key      |

### Association
- belongs_to :user
- has_many   :ingredients



## ingredientsテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| amount             | string     | null: false                   |
| repertoire         | references | null: false,foreign_key: true |
| conversion_name    | string     | 															|


### Association
- belongs_to :user
- belongs_to :repertoires
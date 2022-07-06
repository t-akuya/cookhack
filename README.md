# Cookhack(クックハック)
### Cookhackは時短に特化した料理と調理に役立つ裏ワザを投稿、共有できるWebアプリケーションです。

<div align="center">
   <img width="1427" alt="スクリーンショット 2022-07-06 13 44 33" src="https://user-images.githubusercontent.com/90121924/177470567-e6d8aba7-012b-480d-9075-c83a890567c3.png">
</div>



## 本番環境
URL: https://cookhack-9989.herokuapp.com/



ログイン情報 
- Eメール: test@test.com
- パスワード: aaaa0000



## 概要
Cookhackは、共働きや育児で忙しい方々の調理時間を短縮し、自分のレパートリーを記録できるサービスです。  
レシピを検索したり、共有することができます。

- 材料、料理名からレシピを検索可能
- "いいね"を押すとマイページに保存できる

実装機能の詳細は、[機能一覧](#機能一覧)をご覧ください


## 制作背景(意図)
誰かの課題を解決できるようなWebアプリを作りたいと考えていたので、まずは一番身近である家族の負担を軽減できたらと思い、制作しました。
"献立を考えるところからが料理"という家族の意見を聞き、家事の中でも特に時間と労力のかかる自炊に関して同じ悩みを抱えている人がどれくらいいるのか調べたところ、調理の時間を短縮したいという人が多くいることがわかりました。このことから、時短料理に特化したレシピサイトに需要があると確信し、制作しました。

参考サイト  
[9割が時短したい!共働きや育児で忙しい現代人](https://prtimes.jp/main/html/rd/p/000000042.000007310.html)



## ターゲットユーザー
ネットリサーチ会社のマイボイスコム（株）のアンケート調査結果によると、週6日以上料理をする人は
- 30代は約45%
- 40代で60%強
- 50～70代で70～80%
- 全体の7割が女性

ですので、ターゲットは  
 料理をする割合が多く、インターネット利用率の多い30代〜40代女性に設定しました。


参考サイト  
[料理に関する調査/アンケートデータベース(MyEL)](https://myel.myvoice.jp/products/detail.php?product_id=14002)


## 工夫したポイント
#### ユーザー目線で必要な機能を実装
1.材料から検索可能
ユーザーが献立を考える際、冷蔵庫にある食材からレシピを検索できるように、料理名からだけでなく材料から検索できる機能を実装しました。

![1](https://user-images.githubusercontent.com/90121924/177514017-e32a5a24-e5a1-4567-a7a5-68665c744072.gif)

2.材料入力フォームの追加、削除
投稿時、ユーザーが材料入力フォームで改行したり分量と組み合わせたりする作業を短縮させるため、材料、分量を一組ずつフォームを自由に増減でき、見た目にもわかりやすく入力できるようにしました。Javascriptを使用し、非同期でフォームの追加、削除が行えます。

![1フォーム追加削除](https://user-images.githubusercontent.com/90121924/177506766-63162132-63c1-4032-a555-5e499b4a7bbd.gif)


## 使用技術(開発環境)
- Ruby 2.6.5
- Rails 6.0.5
- MYSQL 5.6.51
- AWS
	- S3
- RSpec



## 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
	- 画像投稿(Active Strage)
	- セレクトボックス(Active Hash)
	- フォーム追加、削除(Ajax)
- 検索機能
	- 字体不問変換(miyabi)
- いいね機能
- マイページ



## テスト
- RSpec
	- 単体テスト(model)
	- 統合テスト(system)



## ER図
<div>
<img width="837" alt="スクリーンショット 2022-07-05 13 21 00" src="https://user-images.githubusercontent.com/90121924/177248839-7f88a15a-61dd-4287-a4ee-bb65248ae793.png">
</div>



## DB設計

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
- has_many :repertoires, dependent: :destroy
- has_many :cooking_hacks, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :like_hacks, dependent: :destroy
- has_many :liked_repertoires, through: :likes, source: :repertoire



## cooking_hackテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| title              | string     | null: false                   |
| contents           | text       | null: false                   |
| user               | references | null: false                   |

### Association
- belongs_to :user
- has_many :like_hacks, dependent: :destroy
- has_many :liked_users, through: :like_hacks, source: :user
- has_one_attached :hack_image



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
- has_one_attached :image
- belongs_to :user
- has_many :likes, dependent: :destroy
- has_many :liked_users, through: :likes, source: :user
- has_many :ingredients, dependent: :destroy
- accepts_nested_attributes_for :ingredients, allow_destroy: true



## ingredientsテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| amount             | string     | null: false                   |
| repertoire         | references | null: false,foreign_key: true |
| conversion_name    | string     |                               |


### Association
- belongs_to :repertoire



## likeテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| user_id            | references | null: false                   |
| repertoire_id      | references | null: false                   |

### Association
- belongs_to :user
- belongs_to :repertoire


## like_hackテーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| user_id            | references | null: false                   |
| cooking_hack_id    | references | null: false                   |

### Association
- belongs_to :user
- belongs_to :cooking_hack

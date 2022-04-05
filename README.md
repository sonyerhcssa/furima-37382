# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計


## users テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| email              | string      | null: false, unique: true      |
| encrypted_password | string      | null: false                    |
| nickname           | string      | null: false                    |
| first_name         | string      | null: false                    |
| last_name          | string      | null: false                    |
| first_name_kana    | string      | null: false                    |
| last_name_kana     | string      | null: false                    |
| birth_day          | date        | null: false                    |

### Association
- has_many :items
- has_many :purchases


## items

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| item_name          | string      | null: false                    |
| price              | integer     | null: false                    |
| explanation        | text        | null: false                    |
| postage_id         | integer     | null: false                    |
| category_id        | integer     | null: false                    |
| item_status_id     | integer     | null: false                    |
| prefecture_id      | integer     | null: false                    |
| item_send_id       | integer     | null: false                    |
| user               | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase
- has_one_attached :image


## purchases テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| item               | references  | null: false, foreign_key: true |
| user               | references  | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :address


##  addressesテーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| post_code          | string      | null: false                    |
| prefecture_id      | integer     | null: false                    |
| city               | string      | null: false                    |
| address            | string      | null: false                    |
| building           | string      |                                |
| phone_number       | string      | null: false                    |
| purchase           | references  | null: false, foreign_key: true |

### Association
- belongs_to :purchase
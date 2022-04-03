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
| b_year             | string      | null: false                    |
| b_month            | string      | null: false                    |
| b_day              | string      | null: false                    |

### Association
- has_many :items
- has_one :purchases


## items

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| item_name          | string      | null: false                    |
| price              | string      | null: false                    |
| postage            | string      | null: false                    |
| explanation        | string      | null: false                    |
| category           | string      | null: false                    |
| item_status        | string      | null: false                    |
| shipment_source    | string      | null: false                    |
| item_send          | string      | null: false                    |
| user               | references  | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :purchases
- has_one_attached :image


## purchases テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| post_code          | string      | null: false                    |
| prefecture         | string      | null: false                    |
| city               | string      | null: false                    |
| address            | string      | null: false                    |
| building           | string      | null: false                    |
| phone_number       | string      | null: false                    |
| item               | references  | null: false, foreign_key: true |
| user               | references  | null: false, foreign_key: true |

### Association
- belongs_to :items
- belongs_to :users
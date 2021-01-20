# README
# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| first_name      | text   | null: false |
| last_name       | text   | null: false |
| kana_first_name | text   | null: false |
| kana_last_name  | string | null: false |
| year_birth      | text   | null: false |
| month_birth     | text   | null: false |
| day_birth       | text   | null: false |


### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| image               | string     | null: false                    |
| product_name        | text       | null: false                    |
| product_description | text       | null: false                    |
| category            | references | null: false, foreign_key: true |
| product_condition   | string     | null: false                    |
| shipping_charges    | text       | null: false                    |
| shipping_area       | text       | null: false                    |
| days_to_ship        | references | null: false, foreign_key: true |
| seling_price        | string     | null: false                    |

user_id
### Association

- has_many :prototype_users
- has_many :users, through: prototype_users
- has_many :comments

## prototype_users テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| prototype | references | null: false, foreign_key: true |

### Association

- belongs_to :prototype
- belongs_to :user

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       |                                |
| user      | references | null: false, foreign_key: true |
| prototype | references | null: false, foreign_key: true |

### Association

- belongs_to :prototype
- belongs_to :user

has_one:purchase  
belongs_to:purchases
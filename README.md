# README
# テーブル設計

## users テーブル
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| kana_first_name | string | null: false |
| kana_last_name  | string | null: false |
| year_birth      | string | null: false |
| month_birth     | string | null: false |
| day_birth       | string | null: false |

### Association
- has_many :items
- has_many :purchases



## items テーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| image               | string     | null: false                    |
| product_name        | string     | null: false                    |
| product_description | text       | null: false                    |
| category            | string     | null: false                    |
| product_condition   | string     | null: false                    |
| shipping_charges    | string     | null: false                    |
| shipping_area       | string     | null: false                    |
| days_to_ship        | string     | null: false                    |
| selling_price       | string     | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one:purchase 



## purchases テーブル
| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one:purchase 



## enter-delivery-addresses テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefectures   | string     | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association
- belongs_to:purchase
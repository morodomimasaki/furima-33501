class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_charge
  belongs_to :shipping_area
  belongs_to :days_to_ship

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :product_condition_id
    validates :shipping_charge_id
    validates :shipping_area_id
    validates :days_to_ship_id
  end

  with_options presence: true do
    validates :image
    validates :product_name
    validates :product_description
    validates :selling_price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999_999,
                              message: 'is invalid. Input full-width katakana characters.' }
    validates :selling_price, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'is invalid. Input full-width katakana characters.' }
  end
end
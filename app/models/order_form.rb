class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number,
                :token

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :shipping_area_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :address
    validates :municipality
    validates :phone_number, length: { maximum: 11, message: 'is out of setting range' }
    validates :token
  end
  validates :phone_number, format: { with: /\A[0-9]+\z/ }

  def save
    # 購入機能を保存
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 購入するときの情報を保存
    Address.create(postal_code: postal_code, shipping_area_id: shipping_area_id, municipality: municipality, address: address,
                   building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end

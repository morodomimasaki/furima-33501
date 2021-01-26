FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.png')
    end
    product_name                  { '商品名' }
    product_description           { '商品の説明' }
    category_id                   { 1 }
    product_condition_id          { 1 }
    shipping_charge_id            { 1 }
    shipping_area_id              { 1 }
    days_to_ship_id               { 1 }
    selling_price                 { 500 }
    association :user
  end
end

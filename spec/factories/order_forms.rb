FactoryBot.define do
  factory :order_form do
    postal_code       { '123-4567' }
    shipping_area_id  { '43' }
    municipality      { '熊本市' }
    address           { '帯山' }
    phone_number      { '08000000000' }
    building_name     { '青山ハイツ' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end

require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it 'image、product_name、product_description、category_id、product_condition_id、product_condition_id、shipping_charge_id、shipping_area_id、days_to_ship_id、selling_price、user_idが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'product_nameが空では登録できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it 'product_descriptionが空では登録できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      it 'category_idが空では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end
      it 'product_condition_idが空では登録できない' do
        @item.product_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Product condition must be other than 0')
      end
      it 'shipping_charge_idが空では登録できない' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge must be other than 0')
      end
      it 'shipping_area_idが空では登録できない' do
        @item.shipping_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping area must be other than 0')
      end
      it 'days_to_ship_idが空では登録できない' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship must be other than 0')
      end
      it 'selling_priceが空では登録できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it 'selling_priceが299円以下であれば登録できない' do
        @item.selling_price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is invalid. Input full-width katakana characters.')
      end
      it 'selling_priceが10,000,000以上であれば登録できない' do
        @item.selling_price = 10, 0o00, 0o00
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is invalid. Input full-width katakana characters.')
      end
      it 'selling_priceが全角文字では登録できないこと' do
        @item.selling_price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is invalid. Input full-width katakana characters.')
      end
      it 'selling_priceが半角英数混合では登録できないこと' do
        @item.selling_price = 'mm111'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is invalid. Input full-width katakana characters.')
      end
      it 'selling_priceが半角英語だけでは登録できないこと' do
        @item.selling_price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is invalid. Input full-width katakana characters.')
      end
    end
  end
end

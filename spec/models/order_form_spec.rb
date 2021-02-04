require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '商品購入できるとき' do
      it 'postal_code、shipping_area_id、municipality、address、phone_number,tokenが存在すれば登録できる' do
        expect(@order).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @order.building_name = nil
        expect(@order).to be_valid
      end
    end
    context '商品購入できないとき' do
      it 'postal_codeが空では登録できない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがないと保存できないこと' do
        @order.postal_code = '8620908'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'shipping_area_idが0では登録できない' do
        @order.shipping_area_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("Shipping area can't be blank")
      end
      it 'shipping_area_idが空では登録できない' do
        @order.shipping_area_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Shipping area can't be blank")
      end
      it 'municipalityが空では登録できない' do
        @order.municipality = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空では登録できない' do
        @order.address = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11行以内でないと保存できないこと' do
        @order.phone_number = '08008080808080'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is out of setting range')
      end

      it 'phone_numberが英数混合では登録できないこと' do
        @order.phone_number = '0800mmmm'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では登録できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では登録できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

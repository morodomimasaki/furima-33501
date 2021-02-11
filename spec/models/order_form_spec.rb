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
        expect(@order.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeにハイフンがないと保存できないこと' do
        @order.postal_code = '8620908'
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号無効です。 ハイフン（-）を含んでください')
      end
      it 'shipping_area_idが0では登録できない' do
        @order.shipping_area_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を空白にすることはできません")
      end
      it 'shipping_area_idが空では登録できない' do
        @order.shipping_area_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を空白にすることはできません")
      end
      it 'municipalityが空では登録できない' do
        @order.municipality = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("市町村区を入力してください")
      end
      it 'addressが空では登録できない' do
        @order.address = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では登録できない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが11行以内でないと保存できないこと' do
        @order.phone_number = '08008080808080'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号の設定が範囲外です')
      end

      it 'phone_numberが英数混合では登録できないこと' do
        @order.phone_number = '0800mmmm'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'tokenが空では登録できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'user_idが空では登録できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空では登録できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end

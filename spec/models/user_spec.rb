require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、kana_first_name、kana_last_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordとpassword_confirmationが同じでなれけば登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123457'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが英語のみでは登録できないこと' do
        @user.password = 'morodomi'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。半角英数字を入力してください')
      end
      it 'passwordが数字のみでは登録できないこと' do
        @user.password = '1111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。半角英数字を入力してください')
      end
      it 'passwordが全角では登録できないこと(AAAA１１などでテストをお願いいたします)' do
        @user.password = 'AAAA１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。半角英数字を入力してください')
      end
      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'first_name（漢字・ひらがな・カタカナ）以外であれば登録できない' do
        @user.first_name = 'morodomi'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前が無効です。全角文字を入力してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外であれば登録できない' do
        @user.last_name = 'morodomi'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字が無効です。全角文字を入力してください')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("カタカナで名前を入力してください")
      end
      it 'kana_first_nameが全角（カタカナ）以外であれば登録できない' do
        @user.kana_first_name = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('カタカナで名前が無効です。 全角カタカナ文字を入力してください')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("カタカナで苗字を入力してください")
      end
      it 'kana_last_nameが全角（カタカナ）以外であれば登録できない' do
        @user.kana_last_name = 'huga'
        @user.valid?
        expect(@user.errors.full_messages).to include('カタカナで苗字が無効です。 全角カタカナ文字を入力してください')
      end
      it 'birthday空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@がなければ登録できない' do
        @user.email = 'hoge.huga'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'mm11'
        @user.password_confirmation = 'mm11'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
    end
  end
end

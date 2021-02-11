class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :purchases

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'が無効です。半角英数字を入力してください'

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'が無効です。全角文字を入力してください' }
    validates :kana_first_name, :kana_last_name,
              format: { with: /\A[ァ-ヶー－]+\z/, message: 'が無効です。 全角カタカナ文字を入力してください' }
  end
end
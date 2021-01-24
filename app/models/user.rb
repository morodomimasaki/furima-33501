class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Input full-width characters.'

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :kana_first_name, :kana_last_name,
              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }
  end
end

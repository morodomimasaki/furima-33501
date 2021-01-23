class User < ApplicationRecord
    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :first_name
    validates :last_name
    validates :kana_first_name
    validates :kana_last_name
    validates :birthday
    validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: "is invalid. Input full-width characters." }
    validates :first_name,:last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters." }
    validates :kana_first_name,:kana_last_name, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters." }
  end
end
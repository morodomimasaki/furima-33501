class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :items
  has_many :messages
  has_many :purchases
  has_many :sns_credentials


  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
   user = User.where(email: auth.info.email).first_or_initialize(
    nickname: auth.info.name,
      email: auth.info.email
  )
  # userが登録済みであるか判断
  if user.persisted?
    sns.user = user
    sns.save
  end
  { user: user, sns: sns }
  end

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
# == Schema Information
#
# Table name: users
#
#  id                                                       :bigint           not null, primary key
#  email(メールアドレス)                                    :string(255)      not null
#  encrypted_password(パスワード)                           :string(255)      not null
#  provider(OAuthプロバイダー)                              :string(255)
#  remember_created_at(メールアドレスのリメンバー日時)      :datetime
#  reset_password_sent_at(メールアドレスのリセット送信日時) :datetime
#  reset_password_token(メールアドレスのリセットトークン)   :string(255)
#  uid(OAuthユーザーID)                                     :string(255)
#  created_at                                               :datetime         not null
#  updated_at                                               :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < UlidRecord
  has_many :buildings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }

  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end

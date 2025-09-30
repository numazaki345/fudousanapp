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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

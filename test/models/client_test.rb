# == Schema Information
#
# Table name: clients(クライアント)
#
#  id                    :string(26)       not null, primary key
#  email(メールアドレス) :string(255)      not null
#  name(名前)            :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

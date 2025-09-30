# == Schema Information
#
# Table name: emails
#
#  id                    :bigint           not null, primary key
#  building_url(建物URL) :text(65535)      not null
#  email(メールアドレス) :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

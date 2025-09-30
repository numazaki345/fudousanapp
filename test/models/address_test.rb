# == Schema Information
#
# Table name: addresses(住所)
#
#  city(市区町村)        :string(255)      not null
#  prefectures(都道府県) :string(255)      not null
#  town_name(町名)       :string(255)      not null
#  zipcode(郵便番号)     :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  building_id           :string(26)       not null, primary key
#
# Foreign Keys
#
#  fk_addresses_on_building_id  (building_id => buildings.id)
#
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

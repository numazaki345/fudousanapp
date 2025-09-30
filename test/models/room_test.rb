# == Schema Information
#
# Table name: rooms(部屋)
#
#  id                    :string(26)       not null, primary key
#  floor(階数)           :integer          not null
#  madori(間取り)        :string(255)      not null
#  rent(家賃)            :integer          not null
#  room_number(部屋番号) :string(255)      not null
#  square(面積)          :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  building_id           :string(26)
#
# Indexes
#
#  index_rooms_on_building_id  (building_id)
#
# Foreign Keys
#
#  fk_rooms_on_building_id  (building_id => buildings.id)
#
require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

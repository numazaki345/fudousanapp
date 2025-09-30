# == Schema Information
#
# Table name: conditions
#
#  id                          :string(26)       not null, primary key
#  area(エリア)                :string(255)      not null
#  building(建物種別)          :string(255)
#  completion(完成年)          :string(255)
#  madori(間取り)              :string(255)
#  minute(徒歩分数)            :string(255)
#  rent_high(家賃上限)         :string(255)
#  rent_low(家賃下限)          :string(255)
#  rent_option(家賃オプション) :string(255)
#  row(行)                     :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  client_id                   :string(26)
#
# Indexes
#
#  index_conditions_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_conditions_on_client_id  (client_id => clients.id)
#
class Condition < UlidRecord
  belongs_to :client, optional: true, inverse_of: :condition
end

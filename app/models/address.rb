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
class Address < UlidRecord
  self.primary_key = :building_id

  belongs_to :building, optional: false, inverse_of: :address

  validates :zipcode,
            allow_blank: true,
            numericality: { only_integer: true },
            length: { maximum: 7 }
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :town_name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id prefectures city town_name zipcode created_at updated_at]
  end

  # Ransack: 検索を許可する関連
  def self.ransackable_associations(_auth_object = nil)
    %w[building]
  end
end

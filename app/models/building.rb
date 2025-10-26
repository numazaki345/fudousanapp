# == Schema Information
#
# Table name: buildings(建物)
#
#  id                                     :string(26)       not null, primary key
#  balcony_type(バルコニー種別)           :string(255)
#  building_type(建物種別)                :string(255)      not null
#  completion(完成年)                     :integer
#  floor_height(階高)                     :integer
#  name(建物名)                           :string(255)      not null
#  station(最寄り駅)                      :string(255)      not null
#  station_minute(最寄り駅からの徒歩分数) :integer          not null
#  structure_type(構造種別)               :string(255)      not null
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  user_id(ユーザーID)                    :bigint           not null
#
class Building < UlidRecord
  has_one_attached :image
  belongs_to :user, optional: :false, inverse_of: :buildings
  has_one :address, dependent: :destroy, inverse_of: :building
  has_many :rooms, dependent: :destroy, inverse_of: :building

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :short, -> { order(station_minute: :asc) }
  scope :long, -> { order(station_minute: :desc) }
  # scope :high, -> { left_joins(:rooms).order('rooms.rent DESC') }

  validates :completion, allow_blank: true, numericality: { only_integer: true }
  validates :floor_height, allow_blank: true, numericality: { only_integer: true }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id
      name
      station
      station_minute
      building_type
      structure_type
      floor_height
      completion
      balcony_type
      user_id
      created_at
      updated_at
    ]
  end

  # Ransack: 検索を許可する関連
  def self.ransackable_associations(_auth_object = nil)
    %w[
    rooms
    user
    address
    image_attachment
    image_blob
    ]
  end
end

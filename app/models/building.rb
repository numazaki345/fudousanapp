class Building < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one_attached :image
  belongs_to :user

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :short, -> { order(station_minute: :asc) }
  scope :long, -> { order(station_minute: :desc) }

  validates :zipcode, allow_blank: true, numericality: { only_integer: true }, length: { maximum: 7 }
  validates :completion, allow_blank: true, numericality: { only_integer: true }
  validates :floor_height, allow_blank: true, numericality: { only_integer: true }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id name prefectures city town_name zipcode
      station station_minute building_type structure_type
      floor_height completion balcony_type user_id
      created_at updated_at
    ]
  end

  # Ransack: 検索を許可する関連
  def self.ransackable_associations(_auth_object = nil)
    %w[rooms user image_attachment image_blob]
  end
end

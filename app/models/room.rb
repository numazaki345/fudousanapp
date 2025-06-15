class Room < ApplicationRecord
  belongs_to :building
  has_many_attached :images

  validates :rent, allow_blank: true, numericality: { only_integer: true }
  validates :square, allow_blank: true, numericality: { only_integer: true }
  validates :floor, allow_blank: true, numericality: { only_integer: true }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id room_number floor madori square
      rent building_id created_at updated_at
    ]
  end
end

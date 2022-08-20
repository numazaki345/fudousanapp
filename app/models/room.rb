class Room < ApplicationRecord
  belongs_to :building
  has_many_attached :images

  validates :rent, allow_blank: true, numericality: {only_integer: true}
  validates :square, allow_blank: true, numericality: {only_integer: true}
  validates :floor, allow_blank: true, numericality: {only_integer: true}
end

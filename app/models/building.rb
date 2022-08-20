class Building < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one_attached :image
  belongs_to :user

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  validates :zipcode, allow_blank: true, numericality: {only_integer: true}, length: {maximum: 7}
  validates :completion, allow_blank: true, numericality: {only_integer: true}
  validates :floor_height, allow_blank: true, numericality: {only_integer: true}
end

class Building < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one_attached :image
  belongs_to :user

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
end

class Building < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_one_attached :image
end

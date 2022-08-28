class Client < ApplicationRecord
  has_one :condition, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true
end

class Client < ApplicationRecord
  validates :birth, allow_blank: true, numericality: {only_integer: true}
  validates :gender, presence: true
  validates :minute, presence: true
  validates :completion, presence: true
end

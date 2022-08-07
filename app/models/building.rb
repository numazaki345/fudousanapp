class Building < ApplicationRecord
  has_many :madoris, dependent: :destroy
end

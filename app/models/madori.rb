class Madori < ApplicationRecord
  belongs_to :building, optional: true
end

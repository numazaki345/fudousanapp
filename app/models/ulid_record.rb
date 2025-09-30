class UlidRecord < ApplicationRecord
  self.abstract_class = true

  before_validation :generate_id!

  def generate_id!
    self.id ||= ULID.generate if self.class.primary_key == 'id'
  end
end

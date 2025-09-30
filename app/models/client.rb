# == Schema Information
#
# Table name: clients(クライアント)
#
#  id                    :string(26)       not null, primary key
#  email(メールアドレス) :string(255)      not null
#  name(名前)            :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Client < UlidRecord
  has_one :condition, dependent: :destroy, inverse_of: :client
  validates :name, presence: true
  validates :email, presence: true
end

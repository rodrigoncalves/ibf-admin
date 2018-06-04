class User < ApplicationRecord
  include UserAdmin

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:inactive, :active]
  enum role: [:root, :admin, :secretary]

  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { in: 6..20 }

end

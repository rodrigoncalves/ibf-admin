class User < ApplicationRecord
  include UserAdmin

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:inactive, :active]
  enum role: [:root, :admin, :secretary]

  validates :name, :email, :role, :status, presence: true

end

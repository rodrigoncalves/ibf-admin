class User < ApplicationRecord
  include UserAdmin

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:inactive, :active]
  enum role: [:root, :admin, :secretary]

  validates :name, :email, :role, :status, presence: true
  validates :password_confirmation, presence: true, on: :update, if: ->{ not password.blank? }

  after_initialize on: :create do
    self.status ||= :active
  end

end

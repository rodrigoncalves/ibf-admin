class User < ApplicationRecord
  include UserAdmin
  has_paper_trail

  devise :database_authenticatable,
    :rememberable,
    :trackable,
    :validatable,
    :lockable
  enum status: [:inactive, :active]
  enum role: [:root, :admin, :secretary]

  validates :name, :email, :role, :status, :encrypted_password, presence: true
  validates :password_confirmation, presence: true, on: :update, unless: ->{ password.blank? }

  after_initialize on: :create do
    self.status ||= :active
  end

  after_validation do
    lock_access! if self.inactive? and not access_locked?
    unlock_access! if self.active? and access_locked?
  end

end

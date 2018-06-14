class User < ApplicationRecord
  include UserAdmin

  # Devise
  devise :database_authenticatable,
    :rememberable,
    :trackable,
    :validatable,
    :lockable

  # Paper Trail
  has_paper_trail ignore: [
    :id,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :locked_at,
    :updated_at
  ]

  # Enums
  enum status: [:inactive, :active]
  enum role: [:root, :admin, :secretary]

  # Validations
  validates :name, :email, :role, :status, :encrypted_password, presence: true
  validates :password_confirmation, presence: true, on: :update, unless: ->{ password.blank? }

  # Default values
  after_initialize on: :create do
    self.status ||= :active
  end

  # Devise lock logic
  after_validation do
    lock_access! if self.inactive? and not access_locked?
    unlock_access! if self.active? and access_locked?
  end

end

class User < ApplicationRecord
  include UserAdmin

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:active, :inactive]
  enum role: [:root, :admin, :secretary]

  validates :name, :email, :password, :role, :status, presence: true
  validates :password, length: { in: 6..20 }

  def status
    enum_value :status
  end

  def role
    enum_value :role
  end

  private

    def enum_value field
      value = read_attribute field
      I18n::t("activerecord.attributes.user.#{field.to_s}_enum.#{value}") if not value.nil?
    end

end

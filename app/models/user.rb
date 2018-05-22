class User < ApplicationRecord
  include UserAdmin

  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:active, :inactive]
  enum group: [:admin, :secretary]

  def status
    enum_value :status
  end

  def group
    enum_value :group
  end

  private

    def enum_value field
      value = read_attribute field
      I18n::t("activerecord.attributes.user.#{field.to_s}_enum.#{value}")
    end

end

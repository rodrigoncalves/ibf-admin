class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         # :registerable,
         # :recoverable,
         :rememberable,
         :trackable,
         :validatable
  enum status: [:active, :inactive]
  enum kind: [:admin, :secretary]

  def status
    status = read_attribute :status
    I18n::t("activerecord.attributes.user.status_enum.#{status}")
  end

end

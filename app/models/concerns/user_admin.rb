module UserAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      create do
        configure :status, :enum do
          enum do
            Hash[User.statuses.map{|k,v| [I18n::t("activerecord.attributes.user.status_enum.#{k}"),v]}]
          end
        end
        configure :group, :enum do
          enum do
            Hash[User.groups.map{|k,v| [I18n::t("activerecord.attributes.user.group_enum.#{k}"),v]}]
          end
        end
      end
      edit do
        configure :status, :enum do
          enum do
            Hash[User.statuses.map{|k,v| [I18n::t("activerecord.attributes.user.status_enum.#{k}"),v]}]
          end
        end
        configure :group, :enum do
          enum do
            Hash[User.groups.map{|k,v| [I18n::t("activerecord.attributes.user.group_enum.#{k}"),v]}]
          end
        end
      end
    end
  end
end

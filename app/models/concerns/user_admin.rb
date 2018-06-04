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
        configure :role, :enum do
          enum do
            Hash[User.roles.map{|k,v| [I18n::t("activerecord.attributes.user.role_enum.#{k}"),v]}]
          end
        end
      end
      edit do
        configure :status, :enum do
          enum do
            Hash[User.statuses.map{|k,v| [I18n::t("activerecord.attributes.user.status_enum.#{k}"),v]}]
          end
        end
        configure :role, :enum do
          enum do
            Hash[User.roles.map{|k,v| [I18n::t("activerecord.attributes.user.role_enum.#{k}"),v]}]
          end
        end
      end
      list do
        field :name
        field :email
        field :role, :enum do
          pretty_value do
            value = bindings[:object].send(:role)
            I18n::t("activerecord.attributes.user.role_enum.#{value}")
          end
        end
        field :status, :enum do
          pretty_value do
            value = bindings[:object].send(:status)
            I18n::t("activerecord.attributes.user.status_enum.#{value}")
          end
        end
      end
      show do
        field :name
        field :email
        field :role, :enum do
          pretty_value do
            value = bindings[:object].send(:role)
            I18n::t("activerecord.attributes.user.role_enum.#{value}")
          end
        end
        field :status, :enum do
          pretty_value do
            value = bindings[:object].send(:status)
            I18n::t("activerecord.attributes.user.status_enum.#{value}")
          end
        end
        field :created_at
      end
    end
  end

end

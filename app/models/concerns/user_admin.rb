module UserAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      create do
        field :name
        field :email
        field :password do
          required true
        end
        field :password_confirmation do
          required true
        end
        field :role, :enum do
          enum do
            Hash[User.roles.map{|k,v|
              next if k == 'root' and not bindings[:view].current_user.root?
              [I18n::t("activerecord.attributes.user.role_enum.#{k}"),v]
            }]
          end
        end
        field :status, :string do
          read_only true
          help false
          def value
            I18n::t "activerecord.attributes.user.status_enum.active"
          end
        end
      end
      edit do
        field :name
        field :email
        field :password
        field :password_confirmation
        field :role
        field :status
        field :role, :enum do
          enum do
            Hash[User.roles.map{|k,v|
              next if k == 'root' and not bindings[:view].current_user.root?
              [I18n::t("activerecord.attributes.user.role_enum.#{k}"),v]
            }]
          end
          def value
            value = bindings[:object].send(:role)
            I18n::t("activerecord.attributes.user.role_enum.#{value}")
          end
        end
        field :status, :enum do
          enum do
            Hash[User.statuses.map{|k,v|
              [I18n::t("activerecord.attributes.user.status_enum.#{k}"),v]
            }]
          end
          def value
            value = bindings[:object].send(:status)
            I18n::t("activerecord.attributes.user.status_enum.#{value}")
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
      export do
        field :name
        field :email
        field :role
        field :status
      end
    end
  end

end

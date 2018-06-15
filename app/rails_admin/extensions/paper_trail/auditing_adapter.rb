module RailsAdmin
  module Extensions
    module PaperTrail
      class VersionProxy
        def message
          @message = I18n::t("paper_trail.events.#{@version.event}")
          if @version.respond_to?(:changeset) && @version.changeset.present?
            @message + ' [' + @version.changeset.to_a.collect { |c|
              I18n::t("activerecord.attributes.#{@version.item.class.name.downcase}.#{c[0]}") + (c[0]["password"] ? '' : ' = ' + c[1][1].to_s)
            }.join(', ') + ']'
          else
            @message
          end
        end
      end
    end
  end
end

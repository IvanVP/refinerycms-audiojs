module Refinery
  module Audios
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Audios

      engine_name :refinery_audios

      initializer 'attach-refinery-audios-with-dragonfly', :after => :load_config_initializers do |app|
        ::Refinery::Audios::Dragonfly.configure!
        ::Refinery::Audios::Dragonfly.attach!(app)
      end

      initializer "register refinerycms_audios plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "audios"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.audios_admin_audios_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/audios/audio',
            :title => 'title'
          }

        end
      end

      config.to_prepare do
        require 'refinery/audios/dialogs_controller'
      end
      config.after_initialize do
        Refinery.register_extension(Refinery::Audios)
      end
    end
  end
end

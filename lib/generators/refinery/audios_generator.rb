module Refinery
  class AudiosGenerator < Rails::Generators::Base
    source_root File.expand_path('../audios/templates', __FILE__)

    def rake_db
      rake("refinery_audios:install:migrations")
    end

    def generate_audios_initializer
      template "config/initializers/refinery/audios.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "audios.rb")
    end

    def generate_audiojs_init
      template "assets/javascripts/audiojs_init.js", File.join(destination_root, "app", "assets", "javascripts", "audiojs_init.js")
    end

    def generate_audiojs
      template "assets/javascripts/audio.js", File.join(destination_root, "app", "assets", "javascripts", "audio.js")
    end

    def generate_audiojs_swf
      template "assets/javascripts/audiojs.swf", File.join(destination_root, "app", "assets", "javascripts", "audiojs.swf")
    end
    
    def generate_player_graphics
      template "assets/images/player-graphics.gif", File.join(destination_root, "app", "assets", "images", "player-graphics.gif")
    end

  end
end

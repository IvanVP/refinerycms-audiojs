require 'refinerycms-core'
require 'dragonfly'
require 'rack/cache'


module Refinery
  autoload :AudiosGenerator, 'generators/refinery/audios_generator'

  module Audios
    require 'refinery/audios/engine'
    require 'refinery/audios/configuration'
    autoload :Dragonfly, 'refinery/audios/dragonfly'
    autoload :Validators, 'refinery/audios/validators'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end


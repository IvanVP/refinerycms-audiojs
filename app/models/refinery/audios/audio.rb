require 'dragonfly'

module Refinery
  module Audios
    class Audio < Refinery::Core::BaseModel

      self.table_name = 'refinery_audios'
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true
      validate :one_source

      has_many :audio_files, :dependent => :destroy
      accepts_nested_attributes_for :audio_files


      ################## Audio config options
      serialize :config, Hash
      CONFIG_OPTIONS = {
          :preload => "auto", :autoplay => "false", :loop => "false"
      }

      attr_accessible :title, :audio_files_attributes,
                      :position, :config, 
                      *CONFIG_OPTIONS.keys

      # Create getters and setters
      CONFIG_OPTIONS.keys.each do |option|
        define_method option do
          self.config[option]
        end
        define_method "#{option}=" do |value|
          self.config[option] = value
        end
      end
      #######################################

      ########################### Callbacks
      after_initialize :set_default_config
      #####################################

      def audio_to_html (controls = false)
        

        sources = []
        audio_files.each do |file|
          if file.use_external
            sources << ["<source src='#{file.external_url}' type='#{file.file_mime_type}'>"]
          else
            sources << ["<source src='#{file.url}' type='#{file.file_mime_type}'>"]
          end if file.exist?
        end

        html = %Q{<audio id="audio_#{self.id}" preload="#{config[:preload]}"}
        html << %Q{ autoplay="#{config[:autoplay]}"} unless config[:autoplay] == 'false'
        html << %Q{ loop="#{config[:loop]}"} unless config[:loop] == 'false'
        html << %Q{ controls="controls"} if controls
        html << ">#{sources.join}</audio>"
        html.html_safe
      end


      def short_info
        info = []
        audio_files.each do |file|
          info << file.short_info
        end

        info
      end

      ####################################class methods
      class << self
        def per_page(dialog = false)
          dialog ? Audios.pages_per_dialog : Audios.pages_per_admin_index
        end
      end
      #################################################

      private

      def set_default_config
        if new_record? && config.empty?
          CONFIG_OPTIONS.each do |option, value|
            self.send("#{option}=", value)
          end
        end
      end

      def one_source
        errors.add(:audio_files, 'Please select at least one source') if audio_files.empty?
      end

    end

  end
end

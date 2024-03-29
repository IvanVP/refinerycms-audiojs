require 'dragonfly'

module Refinery
  module Audios
    class AudioFile < Refinery::Core::BaseModel

      self.table_name = 'refinery_audio_files'
      acts_as_indexed :fields => [:file_name]

      attr_accessible :file, :file_mime_type, :position, :use_external, :external_url
      belongs_to :audio

      MIME_TYPES = {'.mp3' => 'mpeg'}

      # ############################ Dragonfly
      ::Refinery::Audios::Dragonfly.setup!
      audio_accessor :file

      delegate :ext, :size, :mime_type, :url,
               :to        => :file,
               :allow_nil => true

      # #######################################

      ########################### Validations
      validates :file, :presence => true, :unless => :use_external?
      validates :mime_type, :inclusion => { :in =>  Refinery::Audios.config[:whitelisted_mime_types],
               :message => "Wrong file mime_type" }, :if => :file_name?
      validates :external_url, :presence => true, :if => :use_external?
      #######################################

      before_save :set_mime_type
      before_update :set_mime_type

      def exist?
        use_external ? external_url.present? : file.present?
      end

      def short_info
        if use_external
           ['.link', external_url]
        else
           ['.file', file_name]
        end
      end

      private

      def set_mime_type
        if use_external
            self.file_mime_type = 'audio/mpeg'
        end

      end


    end
  end
end

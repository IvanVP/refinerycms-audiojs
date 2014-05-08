require 'dragonfly'

module Refinery
  module Audios
    module Dragonfly

      class << self
        def setup!
          app_audios = ::Dragonfly[:refinery_audios]

          app_audios.define_macro(::Refinery::Audios::AudioFile, :audio_accessor)

          app_audios.analyser.register(::Dragonfly::Analysis::FileCommandAnalyser)
          app_audios.content_disposition = :attachment
        end

        def configure!
          app_audios = ::Dragonfly[:refinery_audios]
          app_audios.configure_with(:rails) do |c|
            #c.datastore = ::Dragonfly::DataStorage::MongoDataStore.new(:db => MongoMapper.database)
            c.datastore.root_path = Refinery::Audios.datastore_root_path
            c.url_format = Refinery::Audios.dragonfly_url_format
            c.secret = Refinery::Audios.dragonfly_secret
          end

          if ::Refinery::Audios.s3_backend
            app_audios.datastore = ::Dragonfly::DataStorage::S3DataStore.new
            app_audios.datastore.configure do |s3|
              s3.bucket_name = Refinery::Audios.s3_bucket_name
              s3.access_key_id = Refinery::Audios.s3_access_key_id
              s3.secret_access_key = Refinery::Audios.s3_secret_access_key
              # S3 Region otherwise defaults to 'us-east-1'
              s3.region = Refinery::Audios.s3_region if Refinery::Audios.s3_region
            end
          end
        end

        def attach!(app)
          ### Extend active record ###
          app.config.middleware.insert_before Refinery::Audios.dragonfly_insert_before,
                                              'Dragonfly::Middleware', :refinery_audios

          app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
              :verbose     => Rails.env.development?,
              :metastore   => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'meta').to_s)}",
              :entitystore => "file:#{URI.encode(Rails.root.join('tmp', 'dragonfly', 'cache', 'body').to_s)}"
          }
        end
      end

    end
  end
end

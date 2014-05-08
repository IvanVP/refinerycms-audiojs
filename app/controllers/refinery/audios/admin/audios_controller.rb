module Refinery
  module Audios
    module Admin
      class AudiosController < ::Refinery::AdminController

        crudify :'refinery/audios/audio',
                :title_attribute => 'title',
                :xhr_paging => true,
                :order => 'position ASC',
                :sortable => true

        def show
          @audio = Audio.find(params[:id])
        end

        def new
          @audio = Audio.new
          @audio.audio_files.build
        end

        def insert
          search_all_audios if searching?
          find_all_audios
          paginate_audios
        end

        def append_to_wym
          
          @audio = Audio.find(params[:audio_id])
          params['audio'].each do |key, value|
           @audio.config[key.to_sym] = value
          end
          
          @html_for_wym = @audio.audio_to_html(true)
        end

        def dialog_preview
          @audio = Audio.find(params[:id].delete('audio_'))
          @preview_html = @audio.audio_to_html
        end

        private

        def paginate_audios
          @audios = @audios.paginate(:page => params[:page], :per_page => Audio.per_page(true))
        end

      end
    end
  end
end

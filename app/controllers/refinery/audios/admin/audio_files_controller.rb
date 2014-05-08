module Refinery
  module Audios
    module Admin
      class AudioFilesController < ::Refinery::AdminController

        def destroy
          @audio_file = AudioFile.find(params[:id])
          @audio = @audio_file.audio
          @audio_file.destroy
          redirect_to refinery.edit_audios_admin_audio_path(@audio), :notice => "#{@audio_file.file_name} was successfully removed."
        end

      end
    end
  end
end

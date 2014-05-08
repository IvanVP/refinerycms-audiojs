Refinery::Admin::DialogsController.class_eval do
  Refinery::Admin::DialogsController::TYPES << 'audio'
  def find_iframe_src_with_audio
    if @dialog_type == 'audio'
      @iframe_src = refinery.insert_audios_admin_audios_path url_params.merge(:dialog => true)
    else
      find_iframe_src_without_audio
    end
  end
  alias_method_chain :find_iframe_src, :audio
end
Refinery::Core::Engine.routes.append do
 match '/system/audios/*dragonfly', :to => Dragonfly[:refinery_audios]

  # Frontend routes
  namespace :audios do
    resources :audios, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :audios, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :audios do
        post :append_to_wym
        collection do
          post :update_positions
          get :insert
          get :dialog_preview
        end
      end
      resources :audio_files, :only => [:destroy]
    end
  end

end

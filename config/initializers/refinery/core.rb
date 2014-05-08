Refinery::Core.configure do |config|

  # Add extra tags to the wymeditor whitelist e.g. = {'tag' => {'attributes' => {'1' => 'href'}}} or just {'tag' => {}}
  config.wymeditor_whitelist_tags = {'audio' => {'attributes' => {'1' => 'preload', '2' => 'autoplay', '3' => 'loop', '4' => 'controls', 
    '5' => 'source'} }, 'source' => {'attributes' => {'1' => 'src', '2' => 'type'}}}

  # Register extra javascript for backend
  config.register_javascript "refinery/admin/wymeditor_monkeypatch1.js"
  config.register_javascript "refinery/admin/audio.js"

  #Register extra stylesheet for backend (optional options)
  config.register_stylesheet "refinery/admin/audio.css"
end
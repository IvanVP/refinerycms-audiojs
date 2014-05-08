# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-audiojs}
  s.version           = %q{0.0.1}
  s.summary           = %q{Audios extension for Refinery CMS}
  s.description       = %q{Manage audios in RefineryCMS. Use HTML5 audiojs player.}
  s.email             = %q{ipetrakov@gmail.com}
  s.homepage          = %q{}
  s.rubyforge_project = %q{refinerycms-audiojs}
  s.authors           = ['Ivan Petrakov']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency 'dragonfly'
  s.add_dependency 'rack-cache'
  s.add_dependency 'refinerycms-core'
end

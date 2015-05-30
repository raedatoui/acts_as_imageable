$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'acts_as_imageable/version'

Gem::Specification.new do |s|
  s.name        = 'acts_as_imageable'
  s.version     = ActsAsImageable::VERSION
  s.authors     = ['Raed Atoui']
  s.description = 'Plugin/gem that provides image functionality'
  s.summary     = 'Plugin/gem that provides image functionality'
  s.email       = 'raed.atoui@gmail.com'

  s.files =  Dir['lib/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']

  s.has_rdoc = false

  s.require_paths = ['lib']
  s.rubygems_version = '1.3.6'

  s.autorequire = 'acts_as_imageable'

  s.add_dependency 'rails', '>= 3.2'

  # File field
  s.add_dependency 'carrierwave'
  s.add_dependency 'rmagick'

  # Optional -  Serializer
  # s.add_dependency "active_model_serializers", "~> 0.8.0"
end

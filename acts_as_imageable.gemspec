$:.push File.expand_path("../lib", __FILE__)

require "acts_as_imageable/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_imageable"
  s.version     = ActsAsImageable::VERSION
  s.authors     = ["Raed Atoui"]
  s.description = %q{Plugin/gem that provides image functionality}
  s.summary     = %q{Plugin/gem that provides image functionality}
  s.email       = %q{raed.atoui@gmail.com}
  s.homepage    = %q{http://your-majesty.com}


  s.files =  Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.has_rdoc = false

  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}

  s.autorequire = %q{acts_as_imageable}

  # File field
  s.add_dependency "carrierwave"
  s.add_dependency "rmagick"

  # Optional -  Serializer
  # s.add_dependency "active_model_serializers", "~> 0.8.0"

end

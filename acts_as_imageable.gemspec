# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_imageable}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Raed Atoui"]
  s.autorequire = %q{acts_as_imageable}
  s.date = %q{2013-07-23}
  s.description = %q{Plugin/gem that provides image functionality}
  s.email = %q{raed@your-majesty.com}
  s.extra_rdoc_files = ["README.rdoc", "MIT-LICENSE"]
  s.files = ["MIT-LICENSE", "README.rdoc", "lib/acts_as_imageable.rb", "lib/image_methods.rb", "lib/imageable_methods.rb", "lib/generators", "lib/generators/image", "lib/generators/image/image_generator.rb", "lib/generators/image/templates", "lib/generators/image/templates/image.rb", "lib/generators/image/templates/create_images.rb", "lib/generators/image/USEGA", "init.rb", "install.rb"]
  s.has_rdoc = false
  s.homepage = %q{http://your-majesty.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Plugin/gem that provides image functionality}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

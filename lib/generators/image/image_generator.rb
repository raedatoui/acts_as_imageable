require 'rails/generators/migration'

class ImageGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_acts_as_imageable_source_root ||= File.expand_path('../templates', __FILE__)
  end

  def self.next_migration_number(_path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end

  def create_model_file
    template 'image.rb', 'app/models/image.rb'
    template 'file_uploader.rb', 'app/uploaders/acts_as_imageable/file_uploader.rb'
    template 'images_attribute.rb', 'app/models/concerns/acts_as_imageable/images_attribute.rb'
    # this is optional
    # template "image_serializer.rb", "app/serializers/acts_as_imageable/image_serializer.rb"
    migration_template 'create_images.rb', 'db/migrate/create_images.rb'
  end
end

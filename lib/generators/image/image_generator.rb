require 'rails/generators/migration'

class ImageGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_acts_as_imageable_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    template "image.rb", "app/models/image.rb"
    template "file_uploader.rb", "app/uploaders/acts_as_imageable/file_uploader.rb"
    migration_template "create_images.rb", "db/migrate/create_images.rb"
  end
end

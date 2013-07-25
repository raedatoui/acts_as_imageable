### Install

`rails g image`

* _app/models/image.rb_ model file

* _app/uploaders/acts_as_imageable/file_uploader.rb_ carrierwave uploader. add versions and processes here

* _app/models/concerns/acts_as_imageable/images_attribute.rb_ a model concern that adds the images attribute to imageable objects

* _db/migrate/20130725154554_create_images.rb_ migration


### To Do

* clean up tests

# encoding: utf-8

class ActsAsImageable::FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "images/#{model.imageable.class.to_s.underscore}/#{model.imageable.id}/#{model.id}"
  end

  version :medium do
    process resize_to_fit: [280, 2_000_000]
  end

  version :small do
    process resize_to_fit: [120, 2_000_000]
  end
end

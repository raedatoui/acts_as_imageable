# encoding: utf-8

class ActsAsImageable::FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "images/#{model.imageable.class.to_s.underscore}/#{model.imageable.id}/#{model.id}"
  end

end

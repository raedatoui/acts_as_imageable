class Image < ActiveRecord::Base

  include ActsAsImageable::Image

  belongs_to :imageable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  mount_uploader :file, ActsAsImageable::FileUploader

  def active_model_serializer
    ActsAsImageable::ImageSerializer
  end

end

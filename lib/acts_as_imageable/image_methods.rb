module ActsAsImageable
  # including this module into your Image model will give you finders and named scopes
  # useful for working with Images.
  # The named scopes are:
  #   in_order: Returns images in the order they were created (created_at ASC).
  #   recent: Returns images by how recently they were created (created_at DESC).
  #   limit(N): Return no more than N images.
  module Image

    def self.included(image_model)
      image_model.extend Finders
      image_model.scope :in_order, -> { image_model.order('created_at ASC') }
      image_model.scope :recent, -> { image_model.reorder('created_at DESC') }
    end

    def is_image_type?(type)
      type.to_s == role.singularize.to_s
    end

    module Finders
      # Helper class method to look up all images for
      # imageable class name and imageable id.
      def find_images_for_imageable(imageable_str, imageable_id)
        where(["imageable_type = ? and imageable_id = ? and role = ?", imageable_str, imageable_id, role]).order("created_at DESC")
      end

      # Helper class method to look up a imageable object
      # given the imageable class name and id
      def find_imageable(imageable_str, imageable_id)
        model = imageable_str.constantize
        model.respond_to?(:find_images_for) ? model.find(imageable_id) : nil
      end

    end
  end
end
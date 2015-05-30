module ActsAsImageable
  module ImagesAttribute
    extend ActiveSupport::Concern

    included do
      def attributes
        super.merge 'images' => images
      end
    end
  end
end

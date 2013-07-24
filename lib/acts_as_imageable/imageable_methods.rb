require 'active_record'

# ActsAsImageable
module ActsAsImageable
  module Acts #:nodoc:
    module Imageable #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_imageable(*args)
          image_roles = args.to_a.flatten.compact.map(&:to_sym)

          class_attribute :image_types
          self.image_types = (image_roles.blank? ? [:images] : image_roles)

          options = ((args.blank? or args[0].blank?) ? {} : args[0])

          if !image_roles.blank?
            image_roles.each do |role|
              has_many "#{role.to_s}_images".to_sym,
                {:class_name => "Image",
                  :as => :imageable,
                  :dependent => :destroy,
                  :conditions => ["role = ?", role.to_s],
                  :before_add => Proc.new { |x, c| c.role = role.to_s }}
            end
            has_many :all_images, {:as => :imageable, :dependent => :destroy, class_name: "Image"}
          else
            has_many :images, {:as => :imageable, :dependent => :destroy}
          end

          image_types.each do |role|
            method_name = (role == :images ? "images" : "#{role.to_s}_images").to_s
            class_eval %{
              def self.find_#{method_name}_for(obj)
                imageable = self.base_class.name
                Image.find_images_for_imageable(imageable, obj.id, "#{role.to_s}")
              end

              def #{method_name}_ordered_by_submitted
                Image.find_images_for_imageable(self.class.name, id, "#{role.to_s}")
              end

              def add_#{method_name.singularize}(image)
                image.role = "#{role.to_s}"
                #{method_name} << image
              end
            }
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsImageable::Acts::Imageable)
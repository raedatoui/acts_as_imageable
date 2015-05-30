class ActsAsImageable::ImageSerializer < ActiveModel::Serializer
  attributes :id, :file, :role, :created_at, :update_at
end

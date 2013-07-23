class Image < ActiveRecord::Base

  include ActsAsImageable::Image

  belongs_to :imageable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of images.
  #acts_as_voteable

  # NOTE: Images belong to a user
  belongs_to :user

  # NOTE: For Mass Assignment Security
  attr_accessible :file

end

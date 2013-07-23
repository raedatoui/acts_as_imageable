class Post < ActiveRecord::Base
  acts_as_imageable
end

class User < ActiveRecord::Base
end

class Wall < ActiveRecord::Base
  acts_as_imageable :public, :private
end

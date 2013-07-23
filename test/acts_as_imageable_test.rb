require 'minitest/autorun'
require 'test/unit'
require 'logger'
require 'pry'
require File.expand_path(File.dirname(__FILE__) + '/../rails/init')

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

class ActsAsImageableTest < Test::Unit::TestCase

  def setup_images
    require File.expand_path(File.dirname(__FILE__) + '/../lib/generators/image/templates/create_images')
    CreateImages.up
    load(File.expand_path(File.dirname(__FILE__) + '/../lib/generators/image/templates/image.rb'))
  end

  def setup_test_models
    load(File.expand_path(File.dirname(__FILE__) + '/schema.rb'))
    load(File.expand_path(File.dirname(__FILE__) + '/models.rb'))
  end

  def setup
    setup_images
    setup_test_models
  end

  def teardown
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  def test_create_image
    post = Post.create(:text => "Awesome post !")
    assert_not_nil post.images.create(:file => "image.").id

    wall = Wall.create(:name => "My Wall")
    assert_not_nil wall.public_images.create(:file => "image.").id
    assert_not_nil wall.private_images.create(:file => "image.").id
    assert_raise NoMethodError do
      wall.images.create(:file => "Image", :file => "Title")
    end
  end

  def test_fetch_images
    post = Post.create(:text => "Awesome post !")
    post.images.create(:file => "First image.")
    imageable = Post.find(1)
    assert_equal 1, imageable.images.length
    assert_equal "First image.", imageable.images.first.file

    wall = Wall.create(:name => "wall")
    private_image = wall.private_images.create(:file => "wall private image")
    assert_equal [private_image], wall.private_images
    public_image = wall.public_images.create(:file => "wall public image")
    assert_equal [public_image], wall.public_images
  end

  def test_find_images_by_user
    user = User.create(:name => "Mike")
    user2 = User.create(:name => "Fake")
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.", :user => user)
    assert_equal true, Post.find_images_by_user(user).include?(image)
    assert_equal false, Post.find_images_by_user(user2).include?(image)
  end

  def test_find_images_for_imageable
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.")
    assert_equal [image], Image.find_images_for_imageable(post.class.name, post.id)
  end

  def test_find_imageable
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.")
    assert_equal post, Image.find_imageable(post.class.name, post.id)
  end

  def test_find_images_for
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.")
    assert_equal [image], Post.find_images_for(post)

    wall = Wall.create(:name => "wall")
    private_image = wall.private_images.create(:file => "wall private image")
    assert_equal [private_image], Wall.find_private_images_for(wall)

    public_image = wall.public_images.create(:file => "wall public image")
    assert_equal [public_image], Wall.find_public_images_for(wall)
  end

  def test_find_images_by_user
    user = User.create(:name => "Mike")
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.", :user => user)
    assert_equal [image], Post.find_images_by_user(user)

    wall = Wall.create(:name => "wall")
    private_image = wall.private_images.create(:file => "wall private image", :user => user)
    assert_equal [private_image], Wall.find_private_images_by_user(user)

    public_image = wall.public_images.create(:file => "wall public image", :user => user)
    assert_equal [public_image], Wall.find_public_images_by_user(user)
  end

  def test_images_ordered_by_submitted
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.")
    image2 = post.images.create(:file => "Second image.")
    assert_equal [image, image2], post.images_ordered_by_submitted

    wall = Wall.create(:name => "wall")
    private_image = wall.private_images.create(:file => "wall private image")
    private_image2 = wall.private_images.create(:file => "wall private image")
    assert_equal [private_image, private_image2], wall.private_images_ordered_by_submitted

    public_image = wall.public_images.create(:file => "wall public image")
    public_image2 = wall.public_images.create(:file => "wall public image")
    assert_equal [public_image, public_image2], wall.public_images_ordered_by_submitted
  end

  def test_images_ordered_by_submitted
    post = Post.create(:text => "Awesome post !")
    image = post.images.create(:file => "First image.")
    image2 = post.images.create(:file => "Second image.")
    assert_equal [image2, image], post.images.recent

    wall = Wall.create(:name => "wall")
    private_image = wall.private_images.create(:file => "wall private image")
    private_image2 = wall.private_images.create(:file => "wall private image")
    assert_equal [private_image2, private_image], wall.private_images.recent

    public_image = wall.public_images.create(:file => "wall public image")
    public_image2 = wall.public_images.create(:file => "wall public image")
    assert_equal [public_image2, public_image], wall.public_images.recent
  end

  def test_add_image
    post = Post.create(:text => "Awesome post !")
    image = Image.new(:file => "First Image", :image => 'Super image')
    post.add_image(image)
    assert_equal [image], post.images

    wall = Wall.create(:name => "wall")
    private_image = Image.new(:file => "First Image", :image => 'Super image')
    wall.add_private_image(private_image)
    assert_equal [private_image], wall.private_images

    public_image = Image.new(:file => "First Image", :image => 'Super image')
    wall.add_public_image(public_image)
    assert_equal [public_image], wall.public_images
  end

  def test_is_image_type
    post = Post.create(:text => "Awesome post !")
    image = Image.new(:file => "First Image", :image => 'Super image')
    post.add_image(image)
    assert_equal true, image.is_image_type?(:image)

    wall = Wall.create(:name => "wall")
    private_image = Image.new(:file => "First Image", :image => 'Super image')
    wall.add_private_image(private_image)
    assert_equal true, private_image.is_image_type?(:private)

    public_image = Image.new(:file => "First Image", :image => 'Super image')
    wall.add_public_image(public_image)
    assert_equal true, public_image.is_image_type?(:public)
    assert_equal false, public_image.is_image_type?(:image)
  end

end

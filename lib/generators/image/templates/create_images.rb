class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :file
      t.references :imageable, :polymorphic => true
      t.string :role, :default => "images"
      t.timestamps
    end

    add_index :images, :imageable_type
    add_index :images, :imageable_id

  end

  def self.down
    drop_table :images
  end
end

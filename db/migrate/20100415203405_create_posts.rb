class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.integer :author_id
      t.string :permalink
      t.text :content
      t.string :category
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :given_name
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.text :address
      t.text :about
      t.text :interests
      t.string :occupation
      t.string :website
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.integer :recording_id
      t.boolean :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

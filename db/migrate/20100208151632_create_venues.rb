class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :city
      t.string :state
      t.integer :address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end

class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
      t.date :date
      t.integer :venue_id
      t.integer :tour_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end

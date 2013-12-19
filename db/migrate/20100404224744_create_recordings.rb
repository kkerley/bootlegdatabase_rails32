class CreateRecordings < ActiveRecord::Migration
  def self.up
    create_table :recordings do |t|
      t.integer :performance_id
      t.string :taper
      t.string :format
      t.text :lineage
      t.text :notes
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :recordings
  end
end

class BandsPerformers < ActiveRecord::Migration
  def self.up
   create_table :bands_performers, :id => false do |t|
      t.integer :band_id
      t.integer :performer_id

      t.timestamps
    end
    add_index :bands_performers, [:band_id, :performer_id], :unique => true
  end

  def self.down
    remove_index :bands_performers, :column => [:band_id, :performer_id]
    drop_table :bands_performers
  end
end

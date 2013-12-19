class PerformancesPerformers < ActiveRecord::Migration
   def self.up
    create_table :performances_performers, :id => false do |t|
      t.integer :performance_id
      t.integer :performer_id

      t.timestamps
    end
    add_index :performances_performers, [:performance_id, :performer_id], :unique => true
  end

  def self.down
    remove_index :performances_performers, :column => [:performance_id, :performer_id]
    drop_table :performances_performers
  end
end

class CreateBootlegs < ActiveRecord::Migration
  def self.up
    create_table :bootlegs do |t|
      t.integer :recording_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bootlegs
  end
end

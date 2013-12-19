class CreateTapers < ActiveRecord::Migration
  def self.up
    create_table :tapers do |t|
      t.string :name
      t.text :preferred_equipment

      t.timestamps
    end
  end

  def self.down
    drop_table :tapers
  end
end

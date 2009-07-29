class CreateStops < ActiveRecord::Migration
  def self.up
    create_table :stops do |t|
      t.integer :station_id
      t.integer :line_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :stops
  end
end

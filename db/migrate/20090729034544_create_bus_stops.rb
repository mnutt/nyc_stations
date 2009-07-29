class CreateBusStops < ActiveRecord::Migration
  def self.up
    create_table :bus_stops do |t|
      t.integer :stop_id
      t.integer :bus_line_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_stops
  end
end

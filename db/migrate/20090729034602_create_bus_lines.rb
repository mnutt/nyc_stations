class CreateBusLines < ActiveRecord::Migration
  def self.up
    create_table :bus_lines do |t|
      t.integer :name

      t.timestamps
    end
  end

  def self.down
    drop_table :bus_lines
  end
end

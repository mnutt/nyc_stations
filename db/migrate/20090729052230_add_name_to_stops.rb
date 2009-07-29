class AddNameToStops < ActiveRecord::Migration
  def self.up
    add_column :stops, :name, :string
  end

  def self.down
    remove_column :stops, :name
  end
end

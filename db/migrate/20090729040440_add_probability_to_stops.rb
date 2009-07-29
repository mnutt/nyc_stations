class AddProbabilityToStops < ActiveRecord::Migration
  def self.up
    add_column :stops, :always, :boolean
  end

  def self.down
    remove_column :stops, :always
  end
end

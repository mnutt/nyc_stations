class Stop < ActiveRecord::Base
  belongs_to :station
  belongs_to :line
  has_many :bus_stops
  has_many :bus_lines, :through => :bus_stops
end

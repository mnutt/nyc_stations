class BusLine < ActiveRecord::Base
  has_many :bus_stops
  has_many :stops, :through => :bus_stops
end

class BusStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :bus_line
end

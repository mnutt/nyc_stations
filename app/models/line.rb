class Line < ActiveRecord::Base
  has_many :stops, :order => "position ASC", :conditions => "position IS NOT NULL"
  has_many :stations, :through => :stops, :uniq => true, :conditions => "stops.position IS NOT NULL", :order => "stops.position ASC"
end

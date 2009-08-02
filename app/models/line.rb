class Line < ActiveRecord::Base
  has_many :stops, :order => "position ASC"
  has_many :stations, :through => :stops, :uniq => true
end

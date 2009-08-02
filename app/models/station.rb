class Station < ActiveRecord::Base
  has_many :stops
  has_many :lines, :through => :stops, :uniq => true
end

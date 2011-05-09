class City < ActiveRecord::Base
	has_many :users
	attr_accessible :cityname
	
	validates_presence_of :cityname
	
	validates_length_of :cityname, :maximum => 20
	
end

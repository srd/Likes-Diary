class Deal < ActiveRecord::Base
	belongs_to :city
	
	validates :name, :presence => true,
									 :length => {:within => 2..50}

	validates :city_id, :presence => true
	
	validates_numericality_of :originalprice
	validates_numericality_of :discount
	validates_numericality_of :maxattenders
end

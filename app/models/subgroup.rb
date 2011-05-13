class Subgroup < ActiveRecord::Base
	belongs_to :category
	has_many :associations, :dependent => :destroy
	has_many :products, :through => :associations
	
	
	validates :subgroupname, :presence => true, :length => {:within => 2..50}

	validates :category_id, :presence => true
end

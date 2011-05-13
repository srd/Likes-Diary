class Category < ActiveRecord::Base
	belongs_to :maingroup
	has_many :subgroups, :dependent => :destroy
	
	validates :categoryname, :presence => true,
													 :length => {:within => 2..50}

	validates :maingroup_id, :presence => true
end

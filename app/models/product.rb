class Product < ActiveRecord::Base
	has_many :associations, :dependent => :destroy
	has_many :subgroups, :through => :associations

	validates :productname, :presence => true, :length => {:within => 2..500}
	
	def addSubGroup!(subgroup)
		associations.create!(:subgroup_id => subgroup.id)
	end
	
	def removeSubGroup!(subgroup)
		associations.find_by_subgroup_id(subgroup).destroy
	end	
end

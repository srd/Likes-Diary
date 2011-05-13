class Association < ActiveRecord::Base
	belongs_to :subgroup
	belongs_to :product
	
	validates :subgroup_id, :presence => true
	validates :product_id, :presence => true

end

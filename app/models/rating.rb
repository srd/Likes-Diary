class Rating < ActiveRecord::Base
	attr_accessible :value

	belongs_to :user
	belongs_to :product
	belongs_to :ratingcategory
	
	validates :user_id, :presence => true
	validates :product_id, :presence => true
	validates :ratingcategory_id, :presence => true
end

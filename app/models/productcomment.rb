class Productcomment < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	
	validates :user_id, :presence => true
	validates :product_id, :presence => true
	validates :content, :presence => true, :length => {:within => 1..1000}
	
end

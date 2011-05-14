class ProductLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	
	validates :product_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'product_likes.created_at DESC'
end

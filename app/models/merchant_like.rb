class MerchantLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :merchant
	
	validates :merchant_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'merchant_likes.created_at DESC'
end

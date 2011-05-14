class DealLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :deal
	
	validates :deal_id, :presence => true
	validates :user_id, :presence => true
	
	default_scope :order => 'deal_likes.created_at DESC'
end

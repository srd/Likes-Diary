class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :item, :polymorphic => true
	
	default_scope :order => 'created_at DESC'
	
	def self.newsFeed(user) 
		followed_ids = user.following.map(&:id).join(", ")
    where("user_id IN (#{followed_ids}) OR user_id = ?", user)
  end
end

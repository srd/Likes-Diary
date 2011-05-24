class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :item, :polymorphic => true
	
	default_scope :order => 'created_at DESC'
end

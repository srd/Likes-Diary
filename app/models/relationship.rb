class Relationship < ActiveRecord::Base
	attr_accessible :followed_id
	
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"
	
	validates :follower_id, :presence => true
	validates :followed_id, :presence => true

	after_create :log_activity
	
	def log_activity
		Activity.create!(:item => self, :user => self.follower, :action => 'create');
	end
end

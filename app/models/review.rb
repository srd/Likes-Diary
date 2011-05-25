class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	
	default_scope :order => 'created_at DESC'
	
	after_create :log_activity
	
	def log_activity
		Activity.create!(:item => self, :user => self.user, :action => 'create');
	end
end

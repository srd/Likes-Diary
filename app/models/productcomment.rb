class Productcomment < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	
	validates :user_id, :presence => true
	validates :product_id, :presence => true
	validates :content, :presence => true, :length => {:within => 1..1000}
	
	after_create :log_activity
	
	default_scope :order => 'created_at DESC'
	
	def log_activity
		Activity.create!(:item => self, :user => self.user, :action => 'create');
	end
end

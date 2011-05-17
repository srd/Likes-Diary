class User < ActiveRecord::Base
  acts_as_authentic do |c|
		failed_login_ban_for = 24.hours
  end
	
  belongs_to :city
  has_many :relationships, :foreign_key => "follower_id",
													 :dependent => :destroy
	
	has_many :following, :through => :relationships, :source => :followed
	
	has_many :reverse_relationships, :foreign_key => "followed_id",
																	 :class_name => "Relationship",
																	 :dependent => :destroy

	has_many :followers, :through => :reverse_relationships, :source => :follower
	
	has_many :product_likes, :dependent => :destroy
	has_many :products, :through => :product_likes
	
	has_many :deal_likes, :dependent => :destroy
	has_many :deals, :through => :deal_likes
	
	has_many :productcomments, :dependent => :destroy
	
	has_many :dealcomments, :dependent => :destroy
	
	has_attached_file :photo, :styles => { 
							:thumb => "50x50#", 
							:small => "150x150>" }
	
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end
	
	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end
	
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	
end

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
	
	has_many :merchant_likes, :dependent => :destroy
	has_many :merchants, :through => :merchant_likes
	
	has_many :productcomments, :dependent => :destroy
	
	has_many :reviews, :dependent => :destroy
	
	has_many :dealcomments, :dependent => :destroy
	
	has_many :merchantcomments, :dependent => :destroy
	
	has_many :ratings
	
	has_attached_file :photo, :styles => { 
							:thumb => "50x50#", 
							:small => "150x150>" }, :default_url => '/images/users/missing_:style.jpg'
							
	has_many :activities
	
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

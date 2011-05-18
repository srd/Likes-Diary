class Merchant < ActiveRecord::Base
	belongs_to :city

	has_many :deals

	has_many :merchant_likes, :dependent => :destroy
  has_many :users, :through => :merchant_likes
	
	has_many :merchantcomments, :dependent => :destroy
  has_many :commenters, :class_name => 'User', :through => :merchantcomments

	def merchantliked?(user)#has the current user liked the merchant
		merchant_likes.find_by_user_id(user)
	end
	
	def likeMerchant!(user)
		merchant_likes.create!(:user_id => user.id)
	end
	
	def unlikeMerchant!(user)
		merchant_likes.find_by_user_id(user).destroy
	end
	
	def addComment!(comment)
		merchantcomments.create!(:user_id => comment.user_id, :content => comment.content)
	end
end

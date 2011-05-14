class Deal < ActiveRecord::Base
	belongs_to :city
	
	has_many :deal_likes, :dependent => :destroy
  has_many :users, :through => :deal_likes
	
	validates :name, :presence => true,
									 :length => {:within => 2..50}

	validates :city_id, :presence => true
	
	validates_numericality_of :originalprice
	validates_numericality_of :discount
	validates_numericality_of :maxattenders
	
	def dealliked?(user)#has the current user liked the deal
		deal_likes.find_by_user_id(user)
	end
	
	def likeDeal!(user)
		deal_likes.create!(:user_id => user.id)
	end
	
	def unlikeDeal!(user)
		deal_likes.find_by_user_id(user).destroy
	end
end

class Deal < ActiveRecord::Base
	belongs_to :city
	belongs_to :merchant
	
	has_many :deal_likes, :dependent => :destroy
  has_many :users, :through => :deal_likes
	
	has_many :dealcomments, :dependent => :destroy
  has_many :commenters, :class_name => 'User', :through => :dealcomments
	
	has_attached_file :photo,
    :styles => {
      :thumb=> "75x75#",
      :small  => "400x400>" }
	
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
	
	def addComment!(comment)
		dealcomments.create!(:user_id => comment.user_id, :content => comment.content)
	end
	
	default_scope :order => 'created_at DESC'
	scope :citydeals, lambda {|city_id| where(:city_id => city_id) }
	
	def current?
    now = DateTime.now
    startat < now && now < endat
  end
	
	def old?
		now = DateTime.now
		endat < now
	end
	
	def future?
		now = DateTime.now
		startat < now
	end
	
end

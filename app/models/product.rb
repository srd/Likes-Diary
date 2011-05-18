class Product < ActiveRecord::Base
	has_many :associations, :dependent => :destroy
	has_many :subgroups, :through => :associations
	
	has_many :product_likes, :dependent => :destroy
  has_many :users, :through => :product_likes
	
	has_many :productcomments, :dependent => :destroy
  has_many :commenters, :class_name => 'User', :through => :productcomments

	validates :productname, :presence => true, :length => {:within => 2..500}
	
	has_attached_file :photo,
    :styles => {
      :thumb=> "75x75#",
      :small  => "200x200>" }
	
	def addSubGroup!(subgroup)
		associations.create!(:subgroup_id => subgroup.id)
	end
	
	def addComment!(comment)
		productcomments.create!(:user_id => comment.user_id, :content => comment.content)
	end
	
	def removeSubGroup!(subgroup)
		associations.find_by_subgroup_id(subgroup).destroy
	end	
	
	def productliked?(user)#has the current user liked the product
		product_likes.find_by_user_id(user)
	end
	
	def likeProduct!(user)
		product_likes.create!(:user_id => user.id)
	end
	
	def unlikeProduct!(user)
		product_likes.find_by_user_id(user).destroy
	end
end

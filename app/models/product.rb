require "open-uri"

class Product < ActiveRecord::Base
	has_many :associations, :dependent => :destroy
	has_many :subgroups, :through => :associations
	
	has_many :product_likes, :dependent => :destroy
  has_many :users, :through => :product_likes
	
	has_many :productcomments, :dependent => :destroy
  has_many :commenters, :class_name => 'User', :through => :productcomments
	
	has_many :reviews, :dependent => :destroy
  has_many :reviewers, :class_name => 'User', :through => :reviews

	validates :productname, :presence => true, :length => {:within => 2..500}
	
	has_many :ratings
	
	has_attached_file :photo,
    :styles => {
      :thumb=> "75x75#",
      :small  => "200x200>" }, :default_url => '/images/missing_:style.jpg'

	def picture_from_url(url)
	    self.photo = open(url)
	end
	
	def addSubGroup!(subgroup)
		associations.create!(:subgroup_id => subgroup.id)
	end
	
	def addComment!(comment)
		productcomments.create!(:user_id => comment.user_id, :content => comment.content)
	end
	
	def addReview!(review)
		reviews.create!(:user_id => review.user_id, :content => review.content)
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
	
	def average_rating
		return 10;
		#todo change later
    @value = 0
    self.ratings.each do |rating|
        @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
	end
	
	def self.paginationCount
		3
	end
	
	def self.search(search)  
		if search  
			where('productname LIKE ?',"%#{search}%")
			#TODO sql injection possible???
		else  
			scoped
		end  
	end  
	
	def self.commonsearch(search)  
		if search  
			where('productname LIKE ?',"%#{search}%").limit(paginationCount)
			#TODO sql injection possible???
		else
			limit(self.paginationCount)
		end
	end
end

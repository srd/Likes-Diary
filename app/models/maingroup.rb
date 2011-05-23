class Maingroup < ActiveRecord::Base
	has_many :categories, :dependent => :destroy
	has_many :ratingcategories, :dependent => :destroy
	
	validates :name, :presence => true, :length => {:within => 2..50}

end

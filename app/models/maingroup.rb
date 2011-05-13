class Maingroup < ActiveRecord::Base
	has_many :categories, :dependent => :destroy
	
	validates :name, :presence => true, :length => {:within => 2..50}

end

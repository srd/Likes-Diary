class Product < ActiveRecord::Base
	has_many :associations, :dependent => :destroy
	has_many :subgroups, :through => :associations

	validates :productname, :presence => true, :length => {:within => 2..500}
end

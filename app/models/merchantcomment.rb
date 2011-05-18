class Merchantcomment < ActiveRecord::Base
	belongs_to :user
	belongs_to :merchant
	
	validates :user_id, :presence => true
	validates :merchant_id, :presence => true
	validates :content, :presence => true, :length => {:within => 1..1000}
end

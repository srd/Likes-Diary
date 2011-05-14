class Dealcomment < ActiveRecord::Base
	belongs_to :user
	belongs_to :deal
	
	validates :user_id, :presence => true
	validates :deal_id, :presence => true
	validates :content, :presence => true, :length => {:within => 1..1000}
end

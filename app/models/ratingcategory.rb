class Ratingcategory < ActiveRecord::Base
	belongs_to :maingroup
	has_many :ratings
end

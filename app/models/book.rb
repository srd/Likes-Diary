class Book < ActiveRecord::Base
	belongs_to :product, :foreign_key => 'p_id'
end

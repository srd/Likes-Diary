module ProductsHelper
	def rating_ballot
		@ratings = current_user.ratings.find_by_product_id(params[:id])
		if !@ratings
			current_user.ratings.new
		else
			@ratings
		end
	end
	
	def current_user_rating
		@ratings = current_user.ratings.find_by_product_id(params[:id])
		if @ratings
				@ratings.value
		else
			"N/A"
		end
	end	
end


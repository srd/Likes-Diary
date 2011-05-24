module ProductsHelper	
	def rating_ballots
		@ratingcat = Product.find_by_id(params[:id]).subgroups[0].category.maingroup.ratingcategories
		@count = @ratingcat.count
		@formratings = {}
		@userratings = current_user.ratings.find_all_by_product_id(params[:id])
		for @ratingca in @ratingcat 
			@formratings[@ratingca.id] = current_user.ratings.new
		end
		if @userratings.length != 0
			for @userrating in @userratings
				if @userrating
					@formratings[@userrating.ratingcategory_id ] = @userrating
				end
			end
		end
		@formratings
	end
	
	def current_user_ratings
		#shift the name of rating category over here and display it in the form as a label
		@count = Product.find_by_id(params[:id]).subgroups[0].category.maingroup.ratingcategories.count
		@currentratings = {}
		@userratings = current_user.ratings.find_all_by_product_id(params[:id])
		if @userratings.length != 0
			for @userrating in @userratings
				if @userrating && @userrating.value != nil
					@currentratings[@userrating.ratingcategory_id] = @userrating.value
				else
					@currentratings[@userrating.ratingcategory_id] = "N/A"
				end
			end
		end
		@currentratings
	end
end
#	def rating_ballot
#		@ratings = current_user.ratings.find_by_product_id(params[:id])
#		if !@ratings
#			current_user.ratings.new
#		else
#			@ratings
#		end
#	end
	
#	def current_user_rating
#		@ratings = current_user.ratings.find_by_product_id(params[:id])
#		if @ratings
#				@ratings.value
#		else
#			"N/A"
#		end
#	end
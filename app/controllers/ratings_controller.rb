class RatingsController < ApplicationController
	before_filter :require_user
  def create
		@product = Product.find_by_id(params[:product_id])
		@ratingcategory = Ratingcategory.find_by_id(params[:ratingcategory_id])
		@rating = Rating.new(params[:rating])
		@rating.product_id = @product.id
		@rating.user_id = current_user.id
		@rating.ratingcategory_id = @ratingcategory.id
		if @rating.save
			respond_to do |format|
				format.html { redirect_to product_path(@product), :notice => "Your rating has been saved" }
				format.js
			end
		end
	end
	
	def update
		@product = Product.find_by_id(params[:product_id])
		@ratingcategory = Ratingcategory.find_by_id(params[:ratingcategory_id])
		@rating = current_user.ratings.find_by_ratingcategory_id(@ratingcategory.id)
		if @rating.update_attributes(params[:rating])
			respond_to do |format|
				format.js
				format.html { redirect_to product_path(@product), :notice => "Your rating has been updated" }
			end
		end
	end
end
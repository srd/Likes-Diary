class ReviewsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authorized_user, :only => :destroy

	def create
		@product = Product.find(params[:product_id])		
		@review = current_user.reviews.build(params[:review])
		@product.addReview!(@review)
		redirect_to @product
	end
	
	def destroy
		@product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to @product
	end
	
	private
  def authorized_user
    @review = Review.find(params[:id])
    redirect_to root_path unless correct_user?(@review.user)
  end
end

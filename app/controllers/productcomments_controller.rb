class ProductcommentsController < ApplicationController
	before_filter :signed_in?
  # look at delete comment later 
	#before_filter :authorized_user, :only => :destroy

	def create
		@product = Product.find(params[:product_id])		
		@productcomment = current_user.productcomments.build(params[:productcomment])
		@product.addComment!(@productcomment)
		redirect_to @product
	end
	
	def destroy
		@product = Product.find(params[:product_id])
    @comment = @product.productcomments.find(params[:id])
    @comment.destroy
    redirect_to @product
	end
	
end

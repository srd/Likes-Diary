class ProductcommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authorized_user, :only => :destroy

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
	
	private
  def authorized_user
    @productcomment = Productcomment.find(params[:id])
    redirect_to root_path unless correct_user?(@productcomment.user)
  end
end

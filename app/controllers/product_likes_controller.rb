class ProductLikesController < ApplicationController
	before_filter :authenticate_user!

  def create
		@product = Product.find_by_id(params[:product_like][:product_id])
		@product.likeProduct!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end

  def destroy
		@like = ProductLike.find(params[:id])
		@product = Product.find_by_id(@like.product_id)
    @product.unlikeProduct!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end
end

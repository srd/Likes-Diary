class AssociationsController < ApplicationController
	def create
		@subgroup = Subgroup.find(params[:association][:subgroup_id])
		@product = Product.find(params[:product_id])
    @product.addSubGroup!(@subgroup)
    redirect_to @product
	end
	
	def destroy
		@subgroup = Subgroup.find(params[:association][:subgroup_id])
		@product = Product.find(params[:product_id])
    @product.removeSubGroup!(@subgroup)
    redirect_to @product
	end
end

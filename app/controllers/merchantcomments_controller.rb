class MerchantcommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :authorized_user, :only => :destroy

	def create
		@merchant = Merchant.find(params[:merchant_id])		
		@merchantcomment = current_user.merchantcomments.build(params[:merchantcomment])
		@merchant.addComment!(@merchantcomment)
		redirect_to @merchant
	end
	
	def destroy
		@merchant = Merchant.find(params[:merchant_id])
    @comment = @merchant.merchantcomments.find(params[:id])
    @comment.destroy
    redirect_to @merchant
	end
	
	private
  def authorized_user
    @merchantcomment = Merchantcomment.find(params[:id])
    redirect_to root_path unless correct_user?(@merchantcomment.user)
  end

end

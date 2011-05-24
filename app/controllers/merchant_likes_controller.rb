class MerchantLikesController < ApplicationController
	before_filter :authenticate_user!

  def create
		@merchant = Merchant.find_by_id(params[:merchant_like][:merchant_id])
		@merchant.likeMerchant!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end

  def destroy
		@like = MerchantLike.find(params[:id])
		@merchant = Merchant.find_by_id(@like.merchant_id)
    @merchant.unlikeMerchant!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end
end

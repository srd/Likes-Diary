class DealLikesController < ApplicationController
	before_filter :authenticate_user!

  def create
		@deal = Deal.find_by_id(params[:deal_like][:deal_id])
		@deal.likeDeal!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end

  def destroy
		@like = DealLike.find(params[:id])
		@deal = Deal.find_by_id(@like.deal_id)
    @deal.unlikeDeal!(current_user)
    respond_to do |format|
      format.html { redirect_to (:back) }
      format.js
    end
  end

end

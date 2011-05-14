class DealcommentsController < ApplicationController
	before_filter :signed_in?
	before_filter :authorized_user, :only => :destroy

	def create
		@deal = Deal.find(params[:deal_id])		
		@dealcomment = current_user.dealcomments.build(params[:dealcomment])
		@deal.addComment!(@dealcomment)
		redirect_to @deal
	end
	
	def destroy
		@deal = Deal.find(params[:deal_id])
    @comment = @deal.dealcomments.find(params[:id])
    @comment.destroy
    redirect_to @deal
	end
	
	private
  def authorized_user
    @dealcomment = Dealcomment.find(params[:id])
    redirect_to root_path unless correct_user?(@dealcomment.user)
  end
end
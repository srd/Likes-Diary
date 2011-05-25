class PagesController < ApplicationController
  layout "signuplogin", :only => [:home]
  def home
		@user = User.new
		@title = "Home"
		if !current_user
			return
		end
		redirect_to users_path#need to make this homepage
  end

  def contact
		@title = "Contact Us"
  end

  def about
		@title = "About Us"
  end
	
	def access
		@title = "Access restricted"
		#TODO *check* directly redirect to root path
	end
	
	def search
		@searchvalue = params[:search]
		@users = User.commonsearch(params[:search])
		@products = Product.commonsearch(params[:search])
		render :layout => 'profile'
	end

end
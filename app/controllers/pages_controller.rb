class PagesController < ApplicationController
  include Facebooker2::Rails::Controller
  layout "signuplogin", :only => [:home]    
  
  def home		
	@user = User.new
	@title = "Home"
	if current_facebook_user		
		begin
			@usr = Mogli::User.find('me',current_facebook_client)
		rescue
			puts "Error => #{$!}"
		end		
	end		
	if current_user
		redirect_to newsfeed_path
	end
  end

  def logUser
	if current_user		
		redirect_to newsfeed_path		
	else		
		redirect_to '/users/sign_in'
	end
  end
  
  def verify_user
	if User.where(:email => params[:email]).exists?
		render :xml => "<success/>"
	else
		render :xml => "<unavail/>"
	end
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
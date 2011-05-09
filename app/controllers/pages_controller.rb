class PagesController < ApplicationController
  def home
	@user_session = UserSession.new
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

end

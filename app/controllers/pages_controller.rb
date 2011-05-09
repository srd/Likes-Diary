class PagesController < ApplicationController
  def home
	@title = "Home"
	if !current_user
	  return
	end
	redirect_to users_path
  end

  def contact
	@title = "Contact Us"
  end

  def about
	@title = "About Us"
  end

end

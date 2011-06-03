class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :correct_user, :is_admin?, :signed_in?, :isadmin?, :signedin?, :correct_user?, :correctuser?
	
	layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "signuplogin"
    else
      "profile"
    end
  end

  private
    def current_user_session
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to users_path
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
		
		def correct_user?(user)
			user == current_user
		end
		
		def correctuser?(user)
			user == current_user
		end
		
		def correct_user
			@user = User.find(params[:id])
			correct_user?(@user)
		end
		
		def is_admin?
			unless current_user.admin
				redirect_to root_path
				return false
			end
			return true
		end
		
		def isadmin?
			unless current_user.admin
				return false
			end
			return true
		end
		
		def signedin?
			user_signed_in?
		end

end
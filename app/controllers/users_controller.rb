class UsersController < ApplicationController
	layout 'profile', :except => [:new]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :following, :followers]
  def new
    @title = "Sign up"
    @user = User.new
		render :layout => 'signuplogin'
  end

  def index
    @title = "Home page"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = @current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully registered!"
      redirect_back_or_default users_path
    else
      render :action => :new
    end
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to users_path
    else
      render :action => :edit
    end
  end
	
	def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

end

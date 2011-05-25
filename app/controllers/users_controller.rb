class UsersController < ApplicationController
	layout 'profile', :except => [:new]
  before_filter :authenticate_user!, :only => [:edit, :update, :following, :followers]
  def new
    @title = "Sign up"
    @user = User.new
		render :layout => 'signuplogin'
  end

  def index
    @title = "Home page"
	@users = User.search(params[:search]).paginate(:page => params[:page], :per_page => User.paginationCount, :order => 'login ASC')
  end

  def show
    @user = User.find(params[:id])
		@activities = @user.activities
		@activitieslength = @activities.length
  end

  def edit
    @user = @current_user
  end

  def create
    @user = User.new(params[:user])
		render 'Hello'
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
    @users = @user.following.paginate(:page => params[:page], :per_page => User.paginationCount, :order => 'login ASC')
		@flag = 0
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page], :per_page => User.paginationCount, :order => 'login ASC')
		@flag = 1
    render 'show_follow'
  end
	
	def feed
		@user = User.find(params[:id])
		@title = @user.login
		@activities = @user.activities
		@activitieslength = @activities.length
	end

end

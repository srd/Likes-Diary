class UsersController < ApplicationController
  layout 'profile', :except => [:new]
  before_filter :authenticate_user!, :only => [:edit, :update, :following, :followers, :newsfeed]
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
	puts 'Creating a user'
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
  
	def getFollowedList(req)
		list = []
		req.each do |r|
			if User.where(:id => r.followed).exists?
				list.push(User.find(r.followed))
			end
		end
		return list
	end
  
	def following
		@title = "Following"
		@user = User.find(params[:id])
		req = Follower.where(:following => current_user.id)
		list = getFollowedList(req)
		@users = list.paginate(:page => params[:page], :per_page => User.paginationCount, :order => 'created_at ASC')
			@flag = 0
		render 'show_follow'
	end

  def followedBy
	list = TempFollower.where(:followed => params[:u_id].to_i , :following => current_user.id)
	if list.length == 0
		list  = TempFollower.new
		list.followed = params[:u_id].to_i
		list.following = current_user.id
		list.save
	end
  end
  
  def getUserList(req)
	list = []
	req.each do |r|
		if User.where(:id => r.following).exists?
			list.push(User.find(r.following))
		end
	end
	return list
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
	req = Follower.where(:followed => current_user.id)
	list=getUserList(req)
    @users = list.paginate(:page => params[:page], :per_page => User.paginationCount, :order => 'login ASC')
		@flag = 1
    render 'show_follow'
  end 
  
	def requests
		@title = "Requests"
		@user  = User.find(params[:id])
		r = TempFollower.where(:followed => params[:id])
		list = getUserList(r)
		@users = list.paginate(:page => params[:page],:per_page => User.paginationCount, :order =>'created_at DESC')
			@flag = 2
		render 'show_request'
	end

	def requestAct
		puts '###########################################'		
		puts 'Action  '+params[:id]+'  '+params[:uid]+'    '+params[:type]				

		temp = TempFollower.where(:followed => params[:id] , :following => params[:uid])
		if temp.length > 0
			TempFollower.delete(temp[0])				
			case params[:type].to_i
			when 1
				#Alow Intaraction
				if Follower.where(:followed => params[:id],:following => params[:uid].to_i).exists? == false
					f=Follower.new
					f.followed = params[:id].to_i
					f.following = params[:uid].to_i
					f.perm = 1
					f.save
				else
					f = Follower.where(:followed => params[:id],:following => params[:uid].to_i)
					Follower.update(f[0].id,:perm => 1)
				end
			when 2
				#follow back
				if Follower.where(:followed => params[:id],:following => params[:uid].to_i).exists? == false
					f=Follower.new
					f.following = params[:uid].to_i
					f.followed = params[:id].to_i
					f.perm = 1
					f.save
				else
					f = Follower.where(:followed => params[:id],:following => params[:uid].to_i)
					Follower.update(f[0].id,:perm => 1)
				end
				if Follower.where(:followed => params[:uid].to_i,:following => params[:id]).exists? == false
					f=Follower.new
					f.followed = params[:uid].to_i                  
					f.following = params[:id].to_i
					f.perm = 1
					f.save					
				else
					f = Follower.where(:followed => params[:uid].to_i,:following => params[:id].to_i)
					Follower.update(f[0].id,:perm => 1)
				end
			when 3
				#Not now
				if Follower.where(:followed => params[:id],:following => params[:uid].to_i).exists? == false
					f = Follower.new
					f.followed = params[:id].to_i
					f.following = params[:uid].to_i
					f.perm=0
					f.save
				end
			end
		end
		
		r = TempFollower.where(:followed => params[:id])
		list = getUserList(r)
		@users = list.paginate(:page => params[:page],:per_page => User.paginationCount, :order =>'created_at DESC')
		
		render :xml => '<done/>'
	end

	def feed
		@user = User.find(params[:id])
		@title = @user.login
		@activities = @user.activities
		@activitieslength = @activities.length
	end
	
	def newsfeed
		@feeditems = Activity.newsFeed(current_user).paginate(:page => params[:page], :per_page => 20)
	end

end

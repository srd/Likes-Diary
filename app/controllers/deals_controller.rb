class DealsController < ApplicationController
	layout 'cheapsdiary'
	before_filter :is_admin?, :only => [:new, :index, :edit, :update, :create, :destroy]
	before_filter :authenticate_user!, :only => [:current_deal]
	
  def new
		@title = "Create a new deal"
		@deal = Deal.new
  end
	
	def create
		@deal = Deal.new(params[:deal])
		if @deal.save
			#add additional checks to see that only a single deal is valid on a day
			redirect_to @deal
			flash[:success] = 'Deal was successfully created'
		else
			render :action => :new
		end
	end
	
	def index
		@deals = Deal.all
	end
	
	def show
		@deal = Deal.find(params[:id])
		@title = @deal.name
		@likers = @deal.users
		@comments = @deal.dealcomments
	end
	
	def edit
		@deal = Deal.find(params[:id])
	end
	
	def update
		@deal = Deal.find(params[:id])
		if @deal.update_attributes(params[:deal])
			redirect_to @deal
			flash[:success] = 'Deal was updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@deal = Deal.find(params[:id])
    @deal.destroy
    flash[:success] = "Deal deleted"
    redirect_to(deals_url)
	end
	
	def currentdeal
		@citydeals = Deal.citydeals(current_user.city_id)
		@current
		@old
		@future
		@citydeals.each do |citydeal|
			if citydeal.current?
				@current = citydeal
				return
			end
			if citydeal.old?
				@old = citydeal
				return
			end
			if citydeal.future?
				@future = citydeal
				return
			end
		end
	end

end

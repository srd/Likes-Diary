class MerchantsController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?, :except => [:show, :index]
  def new
		@title = "Create a new Merchant"
		@merchant = Merchant.new
  end

  def index
		@merchants = Merchant.all
  end

  def show
		@merchant = Merchant.find(params[:id])
		@title = @merchant.merchantname
		@likers = @merchant.users
		@comments = @merchant.merchantcomments
		@deals = @merchant.deals
  end

  def edit
		@merchant = Merchant.find(params[:id])
  end
	
	def create 
		@merchant = Merchant.new(params[:merchant])
		if @merchant.save
			redirect_to @merchant
			flash[:success] = 'Merchant was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@merchant = Merchant.find(params[:id])
		if @merchant.update_attributes(params[:merchant])
			redirect_to @merchant
			flash[:success] = 'Merchant updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@merchant = Merchant.find(params[:id])
		@merchant.destroy
		flash[:success] = 'Merchant deleted'
		redirect_to(merchants_path)
	end
end

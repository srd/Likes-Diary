class SubgroupsController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?, :except => [:show]
  def new
		@title = "Create a new Category"
		@subgroup = Subgroup.new
  end

  def index
		@subgroups = Subgroup.all
  end

  def show
		@subgroup = Subgroup.find(params[:id])
		@title = @subgroup.subgroupname
		@products = @subgroup.products
  end

  def edit
		@subgroup = Subgroup.find(params[:id])
  end
	
	def create 
		@subgroup = Subgroup.new(params[:subgroup])
		if @subgroup.save
			redirect_to @subgroup
			flash[:success] = 'Subgroup was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@subgroup = Subgroup.find(params[:id])
		if @subgroup.update_attributes(params[:subgroup])
			redirect_to @subgroup
			flash[:success] = 'Subgroup updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@subgroup = Subgroup.find(params[:id])
		@subgroup.destroy
		flash[:success] = 'Subgroup deleted'
		redirect_to(subgroups_path)
	end
end

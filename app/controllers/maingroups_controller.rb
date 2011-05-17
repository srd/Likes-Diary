class MaingroupsController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?, :except => [:index, :show]
  def new
		@title = "Create a new Maingroup"
		@maingroup = Maingroup.new
  end

  def index
		@maingroups_all = Maingroup.all
		@maingroups = @maingroups_all.group_by { |t| t.variety }
  end

  def show
		@maingroup = Maingroup.find(params[:id])
		@title = @maingroup.name
		@categories = @maingroup.categories
		@maingroups_all = Maingroup.all
		@maingroups = @maingroups_all.group_by { |t| t.variety }
  end

  def edit
		@maingroup = Maingroup.find(params[:id])
  end
	
	def create 
		@maingroup = Maingroup.new(params[:maingroup])
		if @maingroup.save
			redirect_to @maingroup
			flash[:success] = 'Deal was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@maingroup = Maingroup.find(params[:id])
		if @maingroup.update_attributes(params[:maingroup])
			redirect_to @maingroup
			flash[:success] = 'Maingroup updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@maingroup = Maingroup.find(params[:id])
		@maingroup.destroy
		flash[:success] = 'Maingroup deleted'
		redirect_to(maingroups_path)
	end

end

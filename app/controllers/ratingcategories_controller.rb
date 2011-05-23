class RatingcategoriesController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?
  def new
		@title = "Create a new Rating category"
		@ratingcategory = Ratingcategory.new
  end

  def index
		@ratingcategories = Ratingcategory.all
  end

  def show
		@ratingcategory = Ratingcategory.find(params[:id])
		@title = @ratingcategory.ratingname
  end

  def edit
		@ratingcategory = Ratingcategory.find(params[:id])
  end
	
	def create 
		@ratingcategory = Ratingcategory.new(params[:ratingcategory])
		if @ratingcategory.save
			redirect_to @ratingcategory
			flash[:success] = 'Rating Category was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@ratingcategory = Ratingcateogry.find(params[:id])
		if @ratingcategory.update_attributes(params[:ratingcategory])
			redirect_to @ratingcategory
			flash[:success] = 'Rating Category updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@ratingcategory = Ratingcategory.find(params[:id])
		@ratingcategory.destroy
		flash[:success] = 'Rating category deleted'
		redirect_to(ratingcategories_path)
	end

end

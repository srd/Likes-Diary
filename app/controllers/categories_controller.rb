class CategoriesController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?, :except => [:show]
  def new
		@title = "Create a new Category"
		@category = Category.new
  end

  def index
		@categories = Category.all
  end

  def show
		@category = Category.find(params[:id])
		@title = @category.categoryname
  end

  def edit
		@category = Category.find(params[:id])
  end
	
	def create 
		@category = Category.new(params[:category])
		if @category.save
			redirect_to @category
			flash[:success] = 'Cateory was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to @category
			flash[:success] = 'Category updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		flash[:success] = 'Category deleted'
		redirect_to(categories_path)
	end
end

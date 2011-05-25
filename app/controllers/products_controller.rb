class ProductsController < ApplicationController
	layout 'profile'
	before_filter :is_admin?, :except => [:show, :index]
  def new
		@title = "Create a new Category"
		@product = Product.new
  end

  def index
		@products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => Product.paginationCount, :order => 'productname ASC')
  end

  def show
		@product = Product.find(params[:id])
		@subgroups = @product.subgroups
		@title = @product.productname
		@likers = @product.users
		@comments = @product.productcomments
		@reviews = @product.reviews
  end

  def edit
		@product = Product.find(params[:id])
  end
	
	def create 
		@product = Product.new(params[:product])
		if @product.save
			redirect_to @product
			flash[:success] = 'Product was successfully created'
		else
			render :action => :new
		end
	end
	
	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			redirect_to @product
			flash[:success] = 'Product updated'
		else
			render :action => :edit
		end
	end
	
	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		flash[:success] = 'Product deleted'
		redirect_to(subgroups_path)
	end
	
end

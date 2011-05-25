class ProductsController < ApplicationController
	layout 'likesdiary'
	before_filter :is_admin?, :except => [:show, :index, :users, :reviews]
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
		@comments = @product.productcomments.limit(3)
		@reviews = @product.reviews.limit(1)
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
	
	def users
		@title = "Product Likes"
		@product = Product.find(params[:id])
    @users = @product.users.paginate(:page => params[:page], :per_page => Product.paginationCount, :order => 'login ASC')
		
		render 'likers'
	end
	
	def reviews
		@title = "Product Reviews"
		@product = Product.find(params[:id])
		@reviews = @product.reviews.paginate(:page => params[:page], :per_page => 5)		
		render 'reviewslist'
	end
	
	def productcomments
		@title = "Product Comments"
		@product = Product.find(params[:id])
		@comments = @product.productcomments.paginate(:page => params[:page], :per_page => 30)		
		render 'commentslist'
	end
	
end

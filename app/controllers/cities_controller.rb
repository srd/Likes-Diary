class CitiesController < ApplicationController
	layout 'profile'
	before_filter :is_admin?
  def new
		@title = "New City"
		@city = City.new
  end

  def create
		@city = City.new(params[:city])
    if @city.save
      flash[:notice] = "City added"
      redirect_back_or_default cities_path
    else
      render :action => :new
    end
  end

  def index
		@cities = City.all
  end

end

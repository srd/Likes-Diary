class ProductsController < ApplicationController
	layout 'profile'
	before_filter :is_admin?, :except => [:show, :index, :users, :reviews, :productcomments , :recentupdate ,:friendsupdate,:toplist,:commentlist ,:editSection , :editbyuser,
	:new, :create, :add_image]
  def new
		@title = "Create a new Category"
		@product = Product.new
  end

  def index
		@products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => Product.paginationCount, :order => 'productname ASC')
  end

  def show
		@product = Product.find(params[:id])		
		@title = @product.productname
		@ratings = Ratingtable.where(:p_id => params[:id])		
		@time = Time.new
		@total = 0
		i=0
		rt = @ratings
		rt.each do |r|
			if r.usercount != 0
				@total=@total+(r.netcount/r.usercount)
			end
			i=i+1
		end
		@total = @total/i
		
		case @product.category
			when 1
				@book = Book.where(:p_id => params[:id])
			when 2
				@mobile = Mobile.where(:p_id => params[:id])
			when 3
				@music = Music.where(:p_id => params[:id])						
			when 4
				@compgame = Compgame.where(:p_id => params[:id])		
			when 5
				@beverage = Beverage.where(:p_id => params[:id])				
		end
		
		xml = Builder::XmlMarkup.new
		xml.product {
			xml.name @product.productname
			xml.desc @product.details
			xml.photo @product.photo_file_name
			xml.type  @product.category
			xml.specific {
				case @product.category
					when 1						
						xml.author  @book[0].author
					when 2						
						xml.company  @mobile[0].company
					when 3						
						xml.album  @music[0].album
						xml.artist  @music[0].artist
					when 4						
						xml.company  @compgame[0].company
					when 5						
						xml.company  @beverage[0].company
				end
			}			
			@rate = Ratingtable.where(:p_id => params[:id])
			@rate.each do |r|
				xml.rate {
					xml.cat r.category
					xml.net r.netcount
					xml.users r.usercount
				}
			end
		}
  end

  def likeit
	if current_user
		list = LikesTable.where(:p_id => params[:product_id].to_i,:u_id => current_user.id)
		if list.length == 0
			list = LikesTable.new
			list.u_id = current_user.id
			list.p_id = params[:product_id].to_i
			list.save
		end
	end
  end
  
  def editSection
	xml = Builder::XmlMarkup.new
	if current_user
		edi = Editinfo.find(params[:edit_id].to_i)
		xml.E {
			if edi
				xml.category edi.category
				xml.field1 edi.desc
				xml.field2 edi.review
				case edi.category
					when 1
						b = BookEdit.where(:edit_id => edi.id)
						xml.field3 b[0].about_author
					when 2
						m = MobileEdit.where(:edit_id => edi.id)
						xml.field3 m[0].tech_sup
						xml.field4 m[0].fav_app
					when 3
						m = MusicEdit.where(:edit_id => edi.id)
						xml.field3 m[0].awards
						xml.field4 m[0].lyrics
					when 4
						c = CompgameEdit.where(:edit_id => edi.id)
						xml.field3 c[0].version
						xml.field4 c[0].stages
						xml.field5 c[0].cheetsheet
					when 5
						b = BeverageEdit.where(:edit_id => edi.id)
						xml.field3 b[0].alcohol_content
						xml.field4 b[0].fun_fact
				end
			end
		}
		render :xml => xml.to_xml
	end
  end
  
  def suggestion
  end
  
  def getXML(edits,lower,upper,product_id)
	xml = Builder::XmlMarkup.new
	if edits.length > lower
		xml.edit {
			(lower.to_i..upper.to_i).each do |i|
				if i < edits.length
					user = User.find(edits[i].u_id)
					if user
						xml.E {
							xml.user {
								xml.uid user.id
								xml.pic user.photo.url(:small)
							}
							xml.eid edits[i].id
							xml.likes edits[i].like
							xml.desc edits[i].desc
							xml.rev edits[i].review
							xml.links edits[i].ytube_link
							xml.type edits[i].category
							case edits[i].category
								when 1
									b_edit = BookEdit.where(:edit_id => edits[i].id)
									xml.aboutauthor  b_edit[0].about_author
								when 2
									m_edit = MobileEdit.where(:edit_id => edits[i].id)
									xml.techsup m_edit[0].tech_sup
									xml.app m_edit[0].fav_apps
								when 3
									m_edit = MusicEdit.where(:edit_id => edits[i].id)
									xml.awards m_edit[0].awards
									xml.lyrics m_edit[0].lyrics
								when 4
									c_edit = CompgameEdit.where(:edit_id => edits[i].id)
									xml.stage c_edit[0].stages
									xml.cheet c_edit[0].cheetsheet
									xml.ver c_edit[0].version
								when 5
									b_edit = BeverageEdit.where(:edit_id => edits[i].id)
									xml.content b_edit[0].alcohol_content
									cml.fact b_edit[0].funfact
							end
						}
					end
				end
			end
		}
	else
		return "<empty/>"
	end
	return xml
  end
  
  def getFriends(current_user,edits)
	@following = Follower.where(:following => current_user.id).all(:select => 'followed')
	ed=[]
	i=0
	edits.each do |e|
		i=0
		fList=@following
		fList.each do |f|
			if f.followed == e.u_id
				i=1
			end
		end
		if i==1
			ed.push(e)
		end
	end
	return ed
  end
  
  def recentupdate	
	if current_user
		@edits = Editinfo.where(:p_id => params[:product_id].to_i).all(:order =>'created_at DESC')
		xml = getXML(@edits,params[:lower].to_i,params[:upper].to_i,params[:product_id].to_i)		
		puts xml.text
		render :xml => xml.to_xml
	end	
  end
  
  def friendsupdate
	if current_user		
		@edits = getFriends(current_user,Editinfo.where(:p_id => params[:product_id].to_i).all(:order =>'like DESC'))		
		xml = getXML(@edits,params[:lower].to_i,params[:upper].to_i,params[:product_id].to_i)		
		puts xml.text
		render :xml => xml.to_xml
	end	
  end
  
  def toplist
	if current_user
		@edits = Editinfo.where(:p_id => params[:product_id].to_i).all(:order => 'like DESC')
		xml = getXML(@edits,params[:lower].to_i,params[:upper].to_i,params[:product_id].to_i)
		puts xml.text
		render :xml => xml.to_xml
	end
  end
  
  def commentlist
	if current_user		
		xml = Builder::XmlMarkup.new
		c = Comment.where(:p_id => params[:product_id].to_i).all(:order =>'created_at DESC')		
		xml.commentlist {
			(params[:start].to_i..c.length).each do |k|
				if k > params[:total].to_i
					break
				end
				user = User.find(c[k].u_id)
				if user
					xml.list {
						xml.id c[k].id
						xml.user {
							xml.uid c[k].u_id
							xml.name user.login
							xml.pic user.photo.url(:small)
						}
						xml.cmnt c[k].reply
						rep = Replytocomment.where(:c_id => c[k].id , :p_id => params[:product_id].to_i).all(:order => 'created_at DESC')						
						puts params[:product_id]
						rep.each do |r|
							usr = User.find(r.u_id)
							if usr												
								xml.reply {
									xml.cid r.id
									xml.uid r.u_id
									xml.name usr.login
									xml.pic usr.photo.url(:small)
									xml.says r.comment
								}
							end
						end
					}								
				end
			end
		}
		puts xml.to_xml
		render :xml => xml.to_xml
	end
  end
  
  def editbyuser
	if current_user
		edit = Editinfo.where(:u_id => current_user.id.to_i,:p_id => params[:pid].to_i)
		if edit.length > 0
			Editinfo.update(edit[0].id,{:desc=>params[:field1],:review => params[:field2]})
			case edit[0].category.to_i
				when 1
					BookEdit.update(edit[0].id.to_i,:about_author => params[:field3])
				when 2
					MobileEdit.update(edit[0].id.to_i,{:tech_sup => params[:field3],:fav_apps => params[:field4]})
				when 3
					MusicEdit.update(edit[0].id.to_i,{:awards => params[:field3],:lyrics => params[:field4]})
				when 4				
					CompgameEdit.update(edit[0].id.to_i,{:stages => param[:field4].to_i,:cheetsheet=>params[:field5],:version=>params[:field3]})
				when 5
					BeverageEdit.update(edit[0].id.to_i,{:alcohol_content=>params[:field3],:funfact=>params[:field4]})
			end
		else
			e = Editinfo.new
			e.u_id = current_user.id
			e.p_id = params[:pid].to_i
			e.category = params[:category]
			e.desc = params[:field1]
			e.review = params[:field2]
			if e.save
				case params[:category].to_i
					when 1
						b = BookEdit.new
						b.edit_id = e.id
						b.about_author = params[:field3]
						b.save
					when 2
						m = MobileEdit.new
						m.edit_id = e.id
						m.tech_sup = params[:field3]
						m.fav_apps = params[:field4]
						m.save
					when 3
						m = MusicEdit.new
						m.edit_id = e.id
						m.awards = params[:field3]
						m.lyrics = params[:field4]
						m.save
					when 4
						c = CompgameEdit.new
						c.edit_id = e.id
						c.stages = params[:field4].to_i
						c.cheetsheet = params[:field5]
						c.version = params[:field3]
						c.save
					when 5
						b = BeverageEdit.new
						b.edit_id = e.id
						b.alcohol_content = params[:field3]
						b.funfact = params[:field4]
						b.save
				end
			end			
		end
	end
  end
  
  def commentbyuser
	if current_user
		cmnt = Comment.new
		cmnt.u_id = current_user.id
		cmnt.p_id = params[:product_id].to_i
		cmnt.comment = params[:comment]
		cmnt.save
	end
  end
  
  def replytocomment
	if current_user
		cmnt = Replytocomment.new
		cmnt.u_id = current_user.id
		cmnt.p_id = params[:product_id].to_i
		cmnt.c_id = params[:c_id].to_i
		cmnt.save
	end
  end
  
  def edit
		@product = Product.find(params[:id])
  end
	
	def add_image
		uploaded_io = params[:photo]
	    File.open(Rails.root.join('public', 'images', 'data', uploaded_io.original_filename), 'wb') do |file|
	       file.write(uploaded_io.read)
	    end
		render :inline =>
			"<html><body><img src=\"/images/data/" + uploaded_io.original_filename + "\"></body></html>"
	end

	require 'RMagick'
	def create 
		@product = Product.new(params[:product])
		path = params[:photo]
		url = params[:link]
		if url != ""
			@product.picture_from_url(url)
		end
		@product.save
		if path != ""
			@product.photo_content_type = "image/jpeg"
			@product.photo_file_size = File.size(Rails.root.join('public', path[1,path.length]))
			@product.photo_file_name = path.split('/')[3]
			Dir.mkdir(Rails.root.join('public', 'system', 'photos', @product.id.to_s))
			Dir.mkdir(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'original'))
			Dir.mkdir(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'small'))
			Dir.mkdir(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'thumb'))
			FileUtils.mv(Rails.root.join('public', path[1,path.length]),Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'original', path.split('/')[3]))
			image = Magick::Image.read(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'original', path.split('/')[3])).first
			image_thumb = image.resize_to_fit(75,75)
			image_small = image.resize_to_fit(200,200)
			image_thumb.write(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'thumb', path.split('/')[3]))
			image_small.write(Rails.root.join('public', 'system', 'photos', @product.id.to_s, 'small', path.split('/')[3]))
		end
		if @product.save
			case @product.category
				when 1
					@r1 = Ratingtable.new(:p_id => @product.id, :category => "Romance", :netcount => 0, :usercount => 0)
					@r2 = Ratingtable.new(:p_id => @product.id, :category => "Language", :netcount => 0, :usercount => 0)
					@r3 = Ratingtable.new(:p_id => @product.id, :category => "Read Again", :netcount => 0, :usercount => 0)
					@r4 = Ratingtable.new(:p_id => @product.id, :category => "Thought", :netcount => 0, :usercount => 0)
					@product_param = Book.new(:author => params[:book]["author"], :p_id => @product.id)
				when 2
					@r1 = Ratingtable.new(:p_id => @product.id, :category => "Romance", :netcount => 0, :usercount => 0)
					@r2 = Ratingtable.new(:p_id => @product.id, :category => "Language", :netcount => 0, :usercount => 0)
					@r3 = Ratingtable.new(:p_id => @product.id, :category => "Read Again", :netcount => 0, :usercount => 0)
					@r4 = Ratingtable.new(:p_id => @product.id, :category => "Thought", :netcount => 0, :usercount => 0)
					@product_param = Mobile.new(:company => params[:mobile]["company"], :p_id => @product.id)
				when 3
					@r1 = Ratingtable.new(:p_id => @product.id, :category => "Romance", :netcount => 0, :usercount => 0)
					@r2 = Ratingtable.new(:p_id => @product.id, :category => "Language", :netcount => 0, :usercount => 0)
					@r3 = Ratingtable.new(:p_id => @product.id, :category => "Read Again", :netcount => 0, :usercount => 0)
					@r4 = Ratingtable.new(:p_id => @product.id, :category => "Thought", :netcount => 0, :usercount => 0)
					@product_param = Music.new(:album => params[:music]["album"], :artist => params[:music]["artist"], :p_id => @product.id)
				when 4
					@r1 = Ratingtable.new(:p_id => @product.id, :category => "Romance", :netcount => 0, :usercount => 0)
					@r2 = Ratingtable.new(:p_id => @product.id, :category => "Language", :netcount => 0, :usercount => 0)
					@r3 = Ratingtable.new(:p_id => @product.id, :category => "Read Again", :netcount => 0, :usercount => 0)
					@r4 = Ratingtable.new(:p_id => @product.id, :category => "Thought", :netcount => 0, :usercount => 0)
					@product_param = Compgame.new(:company => params[:compgame]["company"], :p_id => @product.id)
				when 5
					@r1 = Ratingtable.new(:p_id => @product.id, :category => "Romance", :netcount => 0, :usercount => 0)
					@r2 = Ratingtable.new(:p_id => @product.id, :category => "Language", :netcount => 0, :usercount => 0)
					@r3 = Ratingtable.new(:p_id => @product.id, :category => "Read Again", :netcount => 0, :usercount => 0)
					@r4 = Ratingtable.new(:p_id => @product.id, :category => "Thought", :netcount => 0, :usercount => 0)
					@product_param = Beverage.new(:company => params[:beverage]["company"], :p_id => @product.id)
			end
			@r1.save
			@r2.save
			@r3.save
			@r4.save
			@product_param.save
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

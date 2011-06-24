class ProductsController < ApplicationController
	layout 'profile'
	before_filter :is_admin?, :except => [:show, :index, :users, :reviews, :productcomments , :recentupdate ,:friendsupdate,:toplist,:commentlist]
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
		xml = Builder::XmlMarkup.new
		xml.product {
			xml.name @product.productname
			xml.desc @product.details
			xml.photo @product.photo_file_name
			xml.type = @product.type
			xml.specific {
				case @product.type			
					when 1
						@book = Book.where(:p_id => params[:id])
						xml.author = @book[0].author
					when 2
						@mobile = Mobile.where(:p_id => params[:id])
						xml.company = @mobile[0].company
					when 3
						@music = Music.where(:p_id => params[:id])
						xml.album = @music[0].album
						xml.artist = @music[0].artist
					when 4
						@compgame = Compgame.where(:p_id => params[:id])
						xml.company = @compgame[0].company
					when 5
						@beverage = Beverage.where(:p_id => params[:id])
						xml.company = @beverage[0].company
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
		list = LikesTable.where(:p_id => params[:product_id].to_i,:u_id => current_id.id)
		if list.length == 0
			list = LikesTable.new
			list.u_id = current_user.id
			list.p_id = params[:product_id].to_i
			list.save
		end
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
					xml.E {
						xml.user edits[i].u_id
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
		}
	else
		return '<empty/>'.to_xml()
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
		puts xml.to_xml
	end	
  end
  
  def friendsupdate
	if current_user		
		@edits = getFriends(current_user,Editinfo.where(:p_id => params[:product_id].to_i).all(:order =>'like DESC'))		
		xml = getXML(@edits,params[:lower].to_i,params[:upper].to_i,params[:product_id].to_i)
		puts xml.to_xml
	end	
  end
  
  def toplist
	if current_user
		@edits = Editinfo.where(:p_id => params[:product_id].to_i).all(:order => 'like DESC')		
		xml = getXML(@edits,params[:lower].to_i,params[:upper].to_i,params[:product_id].to_i)
		puts xml.to_xml
	end
  end
  
  def commentlist
	if current_user		
		xml = Builder::XmlMarkup.new
		c = Comment.where(:p_id => params[:product_id].to_i).all(:order =>'created_at DESC')
		k=0
		xml.commentlist {
			(0..c.length).each do |k|
				if k > params[:total].to_i
					break
				end
				xml.list {
					xml.id c[k].id
					xml.uid c[k].u_id
					xml.cmnt c[k].reply
					rep = Replytocomment.where(:c_id => c[k].id , :p_id => params[:product_id].to_i).all(:order => 'created_at DESC')
					rep.each do |r|
						xml.reply {
							xml.uid r.u_id
							xml.reply r.comment
						}
					end
				}								
			end
		}
		puts xml.to_xml
	end
  end
  
  def editbyuser
	if current_user
		edit = Editinfos.where(:u_id => current_user.id.to_i,:p_id => params[:product_id].to_i)
		if edit.length > 0
			Editinfo.update(edit[0].id,{:desc=>params[:desc],:review => params[:review],:ytube_link=>params[:link]})
			case edit[0].type.to_i
				when 1
					BookEdit.update(edit[0].id.to_i,:about_author => params[:about])
				when 2
					MobileEdit.update(edit[0].id.to_i,{:tech_sup => params[:techs],:fav_apps => params[:app]})
				when 3
					MusicEdit.update(edit[0].id.to_i,{:awards => params[:award],:lyrics => params[:lyrics]})
				when 4				
					CompgameEdit.update(edit[0].id.to_i,{:stages => param[:stage].to_i,:cheetsheet=>params[:cheet],:version=>params[:ver]})
				when 5
					BeverageEdit.update(edit[0].id.to_i,{:alcohol_content=>params[:content],:funfact=>params[:fact]})
			end
		else
			e = Editinfo.new
			e.u_id = current_user.id
			e.p_id = params[:product_id].to_i
			e.type = params[:type]
			e.desc = params[:desc]
			e.review = params[:review]
			e.ytube_link = params[:link]			
			if e.save
				case params[:type].to_i
					when 1
						b = BookEdit.new
						b.edit_id = e.id
						b.about_author = params[:about]
						b.save
					when 2
						m = MobileEdit.new
						m.edit_id = e.id
						m.tech_sup = params[:techs]
						m.fav_apps = params[:app]
						m.save
					when 3
						m = MusicEdit.new
						m.edit_id = e.id
						m.awards = params[:award]
						m.lyrics = params[:lyrics]
						m.save
					when 4
						c = CompgameEdit.new
						c.edit_id = e.id
						c.stages = params[:stage].to_i
						c.cheetsheet = params[:cheet]
						c.version = params[:ver]
						c.save
					when 5
						b = BeverageEdit.new
						b.edit_id = e.id
						b.alcohol_content = params[:content]
						b.funfact = params[:fact]
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

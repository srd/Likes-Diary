class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
	
  belongs_to :city
  has_many :relationships, :foreign_key => "follower_id",
													 :dependent => :destroy
	
	has_many :following, :through => :relationships, :source => :followed
	
	has_many :reverse_relationships, :foreign_key => "followed_id",
																	 :class_name => "Relationship",
																	 :dependent => :destroy

	has_many :followers, :through => :reverse_relationships, :source => :follower
	
	has_many :product_likes, :dependent => :destroy
	has_many :products, :through => :product_likes
	
	has_many :deal_likes, :dependent => :destroy
	has_many :deals, :through => :deal_likes
	
	has_many :merchant_likes, :dependent => :destroy
	has_many :merchants, :through => :merchant_likes
	
	has_many :productcomments, :dependent => :destroy
	
	has_many :reviews, :dependent => :destroy
	
	has_many :dealcomments, :dependent => :destroy
	
	has_many :merchantcomments, :dependent => :destroy
	
	has_many :ratings
	
	has_attached_file :photo, :styles => { 
							:thumb => "50x50#", 
							:small => "150x150>" }, :default_url => '/images/users/missing_:style.jpg'
							
	has_many :activities
	
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end
	
	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end
	
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	
	def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    # Get the user email info from Facebook for sign up
    # You'll have to figure this part out from the json you get back
    #data = ActiveSupport::JSON.decode(access_token.get('https://graph.facebook.com/me?'))
		data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else
      # Create an user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token)
    end
  end	
	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
end

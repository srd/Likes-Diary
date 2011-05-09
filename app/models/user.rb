class User < ActiveRecord::Base
  acts_as_authentic do |c|
		failed_login_ban_for = 24.hours
  end
	
	belongs_to :city
	
end

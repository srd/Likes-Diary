class AddDeviseFieldsToUsers < ActiveRecord::Migration
  def self.up
	  add_column :users, :reset_password_token, :string, :limit => 255
    add_column :users, :remember_token, :string, :limit => 255
    add_column :users, :remember_created_at, :timestamp
    add_column :users, :authentication_token, :string

    rename_column :users, :crypted_password, :encrypted_password

    remove_column :users, :persistence_token

		add_column :users, :confirmation_token, :string, :limit => 255
		add_column :users, :confirmed_at, :timestamp
		add_column :users, :confirmation_sent_at, :timestamp
		execute "UPDATE users SET confirmed_at = created_at, confirmation_sent_at = created_at"

		rename_column :users, :login_count, :sign_in_count
		rename_column :users, :current_login_at, :current_sign_in_at
		rename_column :users, :last_login_at, :last_sign_in_at
		rename_column :users, :current_login_ip, :current_sign_in_ip
		rename_column :users, :last_login_ip, :last_sign_in_ip
		
		rename_column :users, :failed_login_count, :failed_attempts
		add_column :users, :unlock_token, :string, :limit => 255
		add_column :users, :locked_at, :timestamp
  end

  def self.down
		remove_column :users, :reset_password_token, :string
    remove_column :users, :remember_token, :string
    remove_column :users, :remember_created_at, :timestamp
    remove_column :users, :authentication_token, :string

    rename_column :users, :encrypted_password, :crypted_password

    add_column :users, :persistence_token

		remove_column :users, :confirmation_token, :string
		remove_column :users, :confirmed_at, :timestamp
		remove_column :users, :confirmation_sent_at, :timestamp

		rename_column :users, :sign_in_count, :login_count
		rename_column :users, :current_sign_in_at, :current_login_at
		rename_column :users, :last_sign_in_at, :last_login_at
		rename_column :users, :current_sign_in_ip, :current_login_ip
		rename_column :users, :last_sign_in_ip, :last_login_ip
		
		rename_column :users, :failed_attempts, :failed_login_count
		remove_column :users, :unlock_token, :string
		remove_column :users, :locked_at, :timestamp
  end
end
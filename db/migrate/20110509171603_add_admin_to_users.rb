class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :admin, :default => false
    end
    User.update_all ["admin = ?", true]
  end

  def self.down
    remove_column :users, :admin
  end
end

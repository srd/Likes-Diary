class Addcitytousers < ActiveRecord::Migration
  def self.up
    add_column :users, :city_id, :integer
  end

  def self.down
    remove_column :user, :city_id
  end
end

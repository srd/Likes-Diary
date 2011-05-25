class Changeitemtype < ActiveRecord::Migration
  def self.up
		change_column :activities, :item_type, :string
		execute "UPDATE activities SET item_type = 'productlike'"
  end

  def self.down
		change_column :activities, :item_type, :integer
  end
end

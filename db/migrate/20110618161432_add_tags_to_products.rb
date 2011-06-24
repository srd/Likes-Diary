class AddTagsToProducts < ActiveRecord::Migration
  def self.up
	add_column :products , :tags , :string
	add_column :products , :type , :integer
	add_column :products , :rating_id , :integer
  end

  def self.down
	remove_column :products , :tags
	remove_column :products , :type
	remove_column :products , :rating_id
  end
end

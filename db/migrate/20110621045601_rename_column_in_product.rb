class RenameColumnInProduct < ActiveRecord::Migration
  def self.up
	rename_column :products , :type , :category
  end

  def self.down
  end
end

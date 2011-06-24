class RenameTypeInEditinfo < ActiveRecord::Migration
  def self.up
	rename_column :editinfos , :type , :category
  end

  def self.down
  end
end

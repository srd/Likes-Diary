class AddLikeToEditinfo < ActiveRecord::Migration
  def self.up
	add_column :editinfos, :like , :integer
  end

  def self.down
	remove_column :editinfos , :like
  end
end

class AddpermToFollower < ActiveRecord::Migration
  def self.up
	add_column :followers , :perm , :integer
  end

  def self.down
	remove_column :followers , :perm
  end
end

class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
	  t.integer :followed
	  t.integer :following
      t.timestamps
    end
	add_index :followers ,[:followed,:following], :unique => true
  end

  def self.down
    drop_table :followers
  end
end

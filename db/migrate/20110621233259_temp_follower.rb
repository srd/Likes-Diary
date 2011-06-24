class TempFollower < ActiveRecord::Migration
  def self.up
	create_table :tempfollowers do |t|
		t.integer :followed
		t.integer :following
		t.timestamps
	end	
  end

  def self.down
	drop_table :tempfollowers
  end
end

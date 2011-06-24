class CreateTempFollowers < ActiveRecord::Migration
  def self.up
    create_table :temp_followers do |t|
		t.integer :followed
		t.integer :following
      t.timestamps
    end
  end

  def self.down
    drop_table :temp_followers
  end
end

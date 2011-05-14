class CreateDealLikes < ActiveRecord::Migration
  def self.up
    create_table :deal_likes do |t|
			t.integer :user_id
			t.integer :deal_id
      t.timestamps
    end
		add_index :deal_likes, :user_id
		add_index :deal_likes, :deal_id
		add_index :deal_likes, [:user_id, :deal_id], :unique => true
  end

  def self.down
    drop_table :deal_likes
  end
end

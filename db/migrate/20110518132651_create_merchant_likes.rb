class CreateMerchantLikes < ActiveRecord::Migration
  def self.up
    create_table :merchant_likes do |t|
			t.integer :user_id
			t.integer :merchant_id
			
      t.timestamps
    end
		add_index :merchant_likes, :user_id
		add_index :merchant_likes, :merchant_id
		add_index :merchant_likes, [:user_id, :merchant_id], :unique => true
  end

  def self.down
    drop_table :merchant_likes
  end
end

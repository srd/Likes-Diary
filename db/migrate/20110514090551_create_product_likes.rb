class CreateProductLikes < ActiveRecord::Migration
  def self.up
    create_table :product_likes do |t|
			t.integer :user_id
			t.integer :product_id
			
      t.timestamps
    end
		add_index :product_likes, :user_id
		add_index :product_likes, :product_id
		add_index :product_likes, [:user_id, :product_id], :unique => true
  end

  def self.down
    drop_table :product_likes
  end
end

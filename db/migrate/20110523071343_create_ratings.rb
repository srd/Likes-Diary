class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
			t.integer :user_id
			t.integer :product_id
			t.integer :ratingcategory_id
			t.integer :value
      t.timestamps
    end
		add_index :ratings, :user_id
		add_index :ratings, :product_id
		add_index :ratings, :ratingcategory_id
		add_index :ratings, [:user_id, :product_id, :ratingcategory_id], :unique => true
  end

  def self.down
    drop_table :ratings
  end
end

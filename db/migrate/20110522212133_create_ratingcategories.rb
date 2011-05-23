class CreateRatingcategories < ActiveRecord::Migration
  def self.up
    create_table :ratingcategories do |t|
			t.integer :maingroup_id
			t.string :ratingname
      t.timestamps
    end
		add_index :ratingcategories, :maingroup_id
  end

  def self.down
    drop_table :ratingcategories
  end
end

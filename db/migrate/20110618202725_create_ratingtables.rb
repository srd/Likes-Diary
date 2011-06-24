class CreateRatingtables < ActiveRecord::Migration
  def self.up
    create_table :ratingtables do |t|
	  t.integer :p_id
	  t.string :category
	  t.integer :netcount
	  t.integer  :usercount
      t.timestamps
    end
  end

  def self.down
    drop_table :ratingtables
  end
end

class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
			t.string :categoryname
			t.integer :maingroup_id
      t.timestamps
    end
		add_index :categories, :maingroup_id
  end

  def self.down
    drop_table :categories
  end
end

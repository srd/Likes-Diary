class CreateSubgroups < ActiveRecord::Migration
  def self.up
    create_table :subgroups do |t|
			t.string :subgroupname
			t.integer :category_id
      t.timestamps
    end
		add_index :subgroups, :category_id
  end

  def self.down
    drop_table :subgroups
  end
end

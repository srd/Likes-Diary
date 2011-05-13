class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
			t.integer :subgroup_id
			t.integer :product_id
      t.timestamps
    end
		add_index :associations, :subgroup_id
    add_index :associations, :product_id
    add_index :associations, [:subgroup_id, :product_id], :unique => true
  end

  def self.down
    drop_table :associations
  end
end

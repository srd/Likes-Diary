class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
			t.string :productname
			t.text :details
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

class CreateBeverages < ActiveRecord::Migration
  def self.up
    create_table :beverages do |t|
	  t.integer :p_id
	  t.string :company
      t.timestamps
    end
	add_index :beverages , :p_id ,:unique => true
  end

  def self.down
    drop_table :beverages
  end
end

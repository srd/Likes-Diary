class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
	  t.integer :p_id
	  t.string :company
      t.timestamps
    end
	add_index :mobiles , :p_id ,:unique => true
  end

  def self.down
    drop_table :mobiles
  end
end

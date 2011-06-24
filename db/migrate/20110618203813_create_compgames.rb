class CreateCompgames < ActiveRecord::Migration
  def self.up
    create_table :compgames do |t|
	  t.integer :p_id
	  t.string :company
      t.timestamps
    end
	add_index :compgames ,:p_id ,:unique =>true
  end

  def self.down
    drop_table :compgames
  end
end

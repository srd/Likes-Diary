class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
	  t.integer :p_id
	  t.string :author
      t.timestamps
    end
	add_index :books , :p_id , :unique => true
  end

  def self.down
    drop_table :books
  end
end

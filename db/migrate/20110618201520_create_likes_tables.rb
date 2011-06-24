class CreateLikesTables < ActiveRecord::Migration
  def self.up
    create_table :likes_tables do |t|
		t.integer :u_id
		t.integer :p_id
      t.timestamps
    end
	add_index :likes_tables ,[:u_id,:p_id], :unique => true
  end

  def self.down
    drop_table :likes_tables
  end
end

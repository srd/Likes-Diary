class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
	  t.integer :u_id
	  t.integer :p_id
	  t.string :reply
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

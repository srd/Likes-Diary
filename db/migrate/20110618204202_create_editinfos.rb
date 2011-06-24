class CreateEditinfos < ActiveRecord::Migration
  def self.up
    create_table :editinfos do |t|
	  t.integer :p_id
	  t.integer  :u_id
	  t.integer  :type
	  t.string :desc
	  t.string :review
	  t.string :ytube_link
      t.timestamps
    end
	add_index :editinfos ,[:p_id,:u_id],:unique => true
  end

  def self.down
    drop_table :editinfos
  end
end

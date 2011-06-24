class CreateReplytocomments < ActiveRecord::Migration
  def self.up
    create_table :replytocomments do |t|
	  t.integer :u_id
	  t.integer :p_id
	  t.integer :c_id
	  t.string :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :replytocomments
  end
end

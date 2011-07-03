class CreateEditLikes < ActiveRecord::Migration
  def self.up
    create_table :edit_likes do |t|
		t.integer :edit_id
		t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :edit_likes
  end
end

class CreateDealcomments < ActiveRecord::Migration
  def self.up
    create_table :dealcomments do |t|
			t.integer :user_id
			t.integer :deal_id
			t.string :content
      t.timestamps
    end
		add_index :dealcomments, :deal_id
		add_index :dealcomments, :user_id
  end

  def self.down
    drop_table :dealcomments
  end
end

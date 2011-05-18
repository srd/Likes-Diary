class CreateMerchantcomments < ActiveRecord::Migration
  def self.up
    create_table :merchantcomments do |t|
			t.integer :user_id
			t.integer :merchant_id
			t.string :content
      t.timestamps
    end
		add_index :merchantcomments, :merchant_id
		add_index :merchantcomments, :user_id
  end

  def self.down
    drop_table :merchantcomments
  end
end

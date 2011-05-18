class CreateMerchants < ActiveRecord::Migration
  def self.up
    create_table :merchants do |t|
			t.string :merchantname
			t.text :tribecomment
			t.text :merchantinfo
			t.text :meraddress
			t.text :merchantphone
			t.string :merspectext
      t.timestamps
    end
  end

  def self.down
    drop_table :merchants
  end
end

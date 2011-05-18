class AddMerchantToDeal < ActiveRecord::Migration
  def self.up
		change_table :deals do |t|
      t.integer :merchant_id
    end
    Deal.update_all ["merchant_id = ?", 1]
  end

  def self.down
		remove_column :deals, :merchant_id
  end
end

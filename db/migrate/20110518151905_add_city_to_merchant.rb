class AddCityToMerchant < ActiveRecord::Migration
  def self.up
		change_table :merchants do |t|
      t.integer :city_id
    end
    Merchant.update_all ["city_id = ?", 2]
  end

  def self.down
		remove_column :merchants, :city_id
  end
end

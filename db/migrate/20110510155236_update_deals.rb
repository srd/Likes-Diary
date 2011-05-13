class UpdateDeals < ActiveRecord::Migration
  def self.up
    rename_column :deals, :orginalprice, :originalprice
  end

  def self.down
    rename_column :deals, :originalprice, :orginalprice
  end
end

class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string	:name
			t.integer	:city_id
			t.integer	:orginalprice
			t.integer	:discount
			t.integer	:maxattenders
			t.text	:info1
			t.text	:terms
			t.text	:aboutdeal
			t.text	:info2
			t.text	:address
			t.datetime	:startat
			t.datetime	:endat
			
      t.timestamps
    end
		add_index :deals, :city_id
  end

  def self.down
    drop_table :deals
  end
end

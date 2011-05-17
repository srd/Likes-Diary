class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
		change_table :users do |t|
			t.string :sex
			t.string :profession
			t.date :birthday
			t.text :aboutme
		end
  end

  def self.down
		remove_column :users, :sex
		remove_column :users, :profession
		remove_column :users, :birthday
		remove_column :users, :aboutme
  end
end

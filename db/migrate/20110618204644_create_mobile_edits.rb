class CreateMobileEdits < ActiveRecord::Migration
  def self.up
    create_table :mobile_edits do |t|
	  t.integer :edit_id
	  t.string :tech_sup
	  t.string :fav_apps
      t.timestamps
    end
	add_index :mobile_edits , :edit_id , :unique => true
  end

  def self.down
    drop_table :mobile_edits
  end
end

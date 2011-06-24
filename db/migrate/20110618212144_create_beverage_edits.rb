class CreateBeverageEdits < ActiveRecord::Migration
  def self.up
    create_table :beverage_edits do |t|
		t.integer :edit_id
		t.string :alcohol_content
		t.string :funfact
      t.timestamps
    end
	add_index :beverage_edits , :edit_id ,:unique =>true
  end

  def self.down
    drop_table :beverage_edits
  end
end

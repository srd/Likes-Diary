class CreateCompgameEdits < ActiveRecord::Migration
  def self.up
    create_table :compgame_edits do |t|
	  t.integer :edit_id	
	  t.integer :stages
	  t.string :cheetsheet
	  t.string :version
      t.timestamps
    end
	add_index :compgame_edits ,:edit_id , :unique =>true
  end

  def self.down
    drop_table :compgame_edits
  end
end

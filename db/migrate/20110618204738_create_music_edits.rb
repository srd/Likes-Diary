class CreateMusicEdits < ActiveRecord::Migration
  def self.up
    create_table :music_edits do |t|
	  t.integer :edit_id
	  t.string :awards
	  t.string  :lyrics
      t.timestamps
    end
	add_index :music_edits ,:edit_id , :unique => true
  end

  def self.down
    drop_table :music_edits
  end
end

class CreateMusics < ActiveRecord::Migration
  def self.up
    create_table :musics do |t|
	  t.integer :p_id
	  t.string :album
	  t.string :artist
      t.timestamps
    end
	add_index :musics , :p_id ,:unique => true
  end

  def self.down
    drop_table :musics
  end
end

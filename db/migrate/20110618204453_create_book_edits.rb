class CreateBookEdits < ActiveRecord::Migration
  def self.up
    create_table :book_edits do |t|
      t.integer :edit_id
	  t.string :about_author
      t.timestamps
    end
	add_index :book_edits , :edit_id ,:unique => true
  end

  def self.down
    drop_table :book_edits
  end
end

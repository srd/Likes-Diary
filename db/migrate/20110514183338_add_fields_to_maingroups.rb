class AddFieldsToMaingroups < ActiveRecord::Migration
  def self.up
		change_table :maingroups do |t|
      t.integer :type, :default => 1
    end
    Maingroup.update_all ["type = ?", 2]
  end

  def self.down
		remove_column :maingroups, :type
  end
end

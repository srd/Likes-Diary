class RenameTypeInMaingroups < ActiveRecord::Migration
  def self.up
		change_table :maingroups do |t|
      t.rename :type, :variety
    end
  end

  def self.down
		remove_column :maingroups, :variety, :type
  end
end

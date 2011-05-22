class AddSpecialitiesToMerchants < ActiveRecord::Migration
  def self.up
		add_column :merchants, :speciality1_file_name, :string # Original filename
    add_column :merchants, :speciality1_content_type, :string # Mime type
    add_column :merchants, :speciality1_file_size, :integer # File size in bytes
		add_column :merchants, :speciality2_file_name, :string # Original filename
    add_column :merchants, :speciality2_content_type, :string # Mime type
    add_column :merchants, :speciality2_file_size, :integer # File size in bytes
  end

  def self.down
		remove_column :merchants, :speciality1_file_name
    remove_column :merchants, :speciality1_content_type
    remove_column :merchants, :speciality1_file_size
		remove_column :merchants, :speciality2_file_name
    remove_column :merchants, :speciality2_content_type
    remove_column :merchants, :speciality2_file_size
  end
end

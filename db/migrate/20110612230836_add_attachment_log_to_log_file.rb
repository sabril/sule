class AddAttachmentLogToLogFile < ActiveRecord::Migration
  def self.up
    add_column :log_files, :log_file_name, :string
    add_column :log_files, :log_content_type, :string
    add_column :log_files, :log_file_size, :integer
    add_column :log_files, :log_updated_at, :datetime
  end

  def self.down
    remove_column :log_files, :log_file_name
    remove_column :log_files, :log_content_type
    remove_column :log_files, :log_file_size
    remove_column :log_files, :log_updated_at
  end
end

class CreateLogFiles < ActiveRecord::Migration
  def self.up
    create_table :log_files do |t|
      t.string :file_path
      t.string :log_type
      t.string :first_log_timestamp
      t.string :last_timestamp
      t.integer :last_log_offset, :default => 0
      t.integer :server_id

      t.timestamps
    end
  end

  def self.down
    drop_table :log_files
  end
end

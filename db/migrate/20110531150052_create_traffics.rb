class CreateTraffics < ActiveRecord::Migration
  def self.up
    create_table :traffics do |t|
      t.string :timestamp
      t.string :source_ip
      t.string :status_code
      t.integer :bytes, :default => 0
      t.string :destination
      t.string :authuser
      t.string :content_type
      t.integer :log_file_id
      t.date :date
      t.time :time
    end
  end

  def self.down
    drop_table :traffics
  end
end

class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :title
      t.integer :log_file_id
      t.string :report_type
      t.date :start_date
      t.date :end_date
      t.text :values

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end

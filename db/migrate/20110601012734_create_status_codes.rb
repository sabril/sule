class CreateStatusCodes < ActiveRecord::Migration
  def self.up
    create_table :status_codes do |t|
      t.string :code
      t.string :definition
    end
  end

 
  def self.down
    drop_table :status_codes
  end
  
end

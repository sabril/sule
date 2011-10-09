class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.string :host_name
      t.string :ip_address
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :servers
  end
end

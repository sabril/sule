class Server < ActiveRecord::Base
  validates_presence_of :host_name, :ip_address
  validates_uniqueness_of :ip_address
  has_many :log_files, :dependent => :destroy
  has_many :reports, :through => :log_files
end

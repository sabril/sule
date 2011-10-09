class LogFile < ActiveRecord::Base
  #validates_presence_of :file_path
  belongs_to :server
  has_many :traffics, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  # validate :server, :uniqueness => {:scope => :file_path}
  # validate :check_range, :on => :create
  has_attached_file :log,
                     :url  => "/assets/logs/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/logs/:id/:style/:basename.:extension"
  validates_attachment_presence :log
  validates_attachment_content_type :log, :content_type => ["application/octet-stream", 'text/csv'], :message => "Wrong format"
 
  # private
  # def check_file #validate log file
  #   unless self.start_date.nil? && self.end_date.nil?
  #     if self.start_date > self.end_date
  #       errors.add(:start_date,"Wrong date range")
  #       errors.add(:end_date,"Wrong date range")
  #     end
  #   end
  # end
end

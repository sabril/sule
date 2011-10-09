class Report < ActiveRecord::Base
  belongs_to :log_file
  validates_presence_of :log_file_id, :title, :start_date, :end_date
  validate :check_range, :on => :create
  before_save :create_values
  def server_id
  end

  def server_id=(server_id)
  end
  
  def eval_values
    eval(self.values)
  end
  
  def ips
    ips = Array.new
    for value in eval_values
      for log_1 in value[0]
        ips.push log_1[0]
      end
    end
    ips = ips.to_json.gsub('"',"'")
  end
  
  def ip_counts
    ip_counts = Array.new
    for value in eval_values
      for log_1 in value[0]
        ip_counts.push log_1[1]
      end
    end
    ip_counts
  end
  
  def ip_percents
    total = ip_counts.inject(:+)
    ip_percents = Array.new
    for value in eval_values
      for log_1 in value[0]
        ip_percents.push [log_1[0].gsub('"',"'"),((log_1[1]*100).to_f/total).round(2)]
      end
    end
    ip_percents
  end
  
  def ip_downloads
    ip_downloads = Array.new
    for value in eval_values
      for log_2 in value[1]
        ip_downloads.push(log_2[1].to_i/1024)
      end
    end
    ip_downloads
  end
  
  
  private
  def check_range #validate date range
    unless self.start_date.nil? && self.end_date.nil?
      if self.start_date > self.end_date
        errors.add(:start_date,"Wrong date range")
        errors.add(:end_date,"Wrong date range")
      end
    end
  end
  
  def limit_results(array, limit=20)
    new_arrays = Array.new
    (0..limit).each do |i|
      new_arrays[i] = array[i]
    end
    new_arrays
  end
  
  def sort_results(array)
    array.sort {|a,b| b[1]<=>a[1]}
  end
  
  def create_values
    bad_destinations = ["NONE://"]
    log_file = LogFile.find(log_file_id)
    traffics = Traffic.where("date >= ? AND date <= ?", start_date, end_date)
    ips = {}
    ips_download = {}
    visits = {}
    visits_download = {}
    traffics.each do |traffic|
      ips[traffic.source_ip] = ips.fetch(traffic.source_ip, 0)+1
      ips_download[traffic.source_ip] = ips_download.fetch(traffic.source_ip, 0)+traffic.bytes
      #parse URL
      unless bad_destinations.include?(traffic.destination)
        unless (traffic.destination =~ URI::regexp).nil?
          url = URI.parse(traffic.destination).host
        else
          url = traffic.destination
        end
        if url.nil? or url == ""
          url = "Invalid URL"
        end
        visits[url] = visits.fetch(url, 0)+1
        visits_download[url] = visits_download.fetch(url, 0)+traffic.bytes
      end
    end
    ips = sort_results(ips)
    ips_download = sort_results(ips_download)
    visits = sort_results(visits)
    visits_download = sort_results(visits_download)
    if report_type == "Top IP Access"
      val = {ips, ips_download}
    elsif report_type == "Top Web Visits"
      visits = limit_results(visits,20)
      visits_download = limit_results(visits_download,20)
      val = {visits, visits_download}
    end
    self.values = val.map.inspect
  end
end

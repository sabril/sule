class ReportGeneratorController < ApplicationController
  helper = Object.new.extend(ActionView::Helpers::NumberHelper)
  @servers = Server.all
  bad_destinations = ["NONE://"]
  for server in @servers
    logger.info "Generate report for server ##{server.host_name}"
    logger.info "==============================================="
    for log_file in server.log_files
      ips = {}
      ips_download = {}
      visits = {}
      visits_download = {}
      log_file.traffics.each do |traffic|
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
      ips = ips.sort {|a,b| b[1]<=>a[1]}
      logger.info "Top Accesses by IP:"
      logger.info "==================="
      ips.each{ |ip,count| puts "#{ip}: #{count}"}
      logger.info "\n"
      ips_download = ips_download.sort {|a,b| b[1]<=>a[1]}
      logger.info "Top Download by IP:"
      logger.info "==================="
      ips_download.each{ |ip,count| puts "#{ip}: #{helper.number_to_human_size(count)}"}
      logger.info "\n"
      visits = visits.sort {|a,b| b[1]<=>a[1]}
      logger.info "Top Web Visits:"
      logger.info "==================="
      #visits.each{ |visit,count| puts "#{visit}: #{count}"}
      logger.info "\n"
      visits_download = visits_download.sort {|a,b| b[1]<=>a[1]}
      logger.info "Top Download Web Visits:"
      logger.info "==================="
      #visits_download.each{ |visit,count| puts "#{visit}: #{helper.number_to_human_size(count)}"}
    end
  end
  

end

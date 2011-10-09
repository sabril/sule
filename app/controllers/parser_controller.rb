require 'stringio'
require 'csv'
class ParserController < ApplicationController
  include Enumerable
  puts "Starting..."
  @servers = Server.all #call all server
  if @servers.nil? == false
    for server in @servers
      puts "Processing Server ##{server.id}"
      puts "===================================="
      puts "Listing Log Files..."
      for log_file in server.log_files
        puts "Checking Log File #{log_file.log.path}"
        if File.exist?(log_file.log.path.to_s)
          if log_file.log_type == "Squid log"
            puts "Opening Squid .log File"
            log_contents = File.open(log_file.log.path.to_s)
            #params
            filesize = log_contents.stat.size
            last_offset = log_file.last_log_offset
            puts "Last Log Offset: #{last_offset}"
            puts "Current Offset: #{filesize}"
            puts "Last First log timestamp: #{log_file.first_log_timestamp}"
            # read the first line
            first_line_timestamp = log_contents.read(4096).split("\n")[0].split("\s")[0]
            # puts first_line_timestamp
            if log_file.first_log_timestamp == first_line_timestamp 
              puts "This is a known file.."
              if filesize == log_file.last_log_offset
                puts "File is identic, go to the end of file.."
                log_contents.seek(0, File::SEEK_END)
              else
                puts "Skip to the last offset.."
                log_contents.seek(0, log_contents.tell)
              end
            else
              puts "This is a new file, begin from the first line.."
              log_contents.seek(0, 0)
              # save first_log_timestamp
              log_file.first_log_timestamp = first_line_timestamp
            end
          
            puts "Current file offset: #{log_contents.tell}"
            lines = log_contents.read.split("\n")
            for line in lines
              data = line.split("\s")
              traffic = Traffic.new(
                :timestamp => data[0], 
                :source_ip => data[2], 
                :status_code => data[3], 
                :bytes => data[4], 
                :destination => data[6], 
                :content_type => data[9], 
                :log_file_id => log_file.id,
                :authuser => data[7],
                :date => Time.at(data[0].to_i).strftime("%Y-%m-%d"),
                :time => Time.at(data[0].to_i).strftime("%H:%M:%S")
                )
              traffic.save
            end
            puts "Finised file offset: #{log_contents.tell}"
            log_file.last_log_offset = filesize
            log_file.save
          elsif log_file.log_type == "Radius log"
            puts "Opening Radius .csv File"
            log_contents = FasterCSV.open(log_file.log.path.to_s)
            log_contents.shift
            filesize = log_contents.stat.size
            last_offset = log_file.last_log_offset
            puts "Last Log Offset: #{last_offset}"
            puts "Current Offset: #{filesize}"
            puts "Last First log timestamp: #{log_file.first_log_timestamp}"
            # read the first line
            first_line = log_contents.gets
            first_line_timestamp = Time.parse("#{first_line[0]} #{first_line[1]}").to_i
            if log_file.first_log_timestamp == first_line_timestamp.to_s
              puts "This is a known file.."
              if filesize == log_file.last_log_offset
                puts "File is identic, go to the end of file.."
                log_contents.seek(0, File::SEEK_END)
              else
                puts "Skip to the last offset.."
                log_contents.seek(0, log_contents.tell)
              end
            else
              puts "This is a new file, begin from the first line.."
              log_contents.seek(0, 0)
              log_contents.shift
              # save first_log_timestamp
              log_file.first_log_timestamp = first_line_timestamp
            end
            
            puts "Current file offset: #{log_contents.tell}"
            lines = log_contents.read
            for line in lines
              traffic = Traffic.new(
                :timestamp => Time.parse("#{line[0]} #{line[1]}").to_i, 
                :source_ip => line[7], 
                :status_code => line[2], 
                #:bytes => line[4], 
                :destination => line[5], 
                #:content_type => line[9], 
                :log_file_id => log_file.id,
                :authuser => line[3],
                :date => line[0],
                :time => line[1]
                )
              traffic.save
            end
            puts "Finised file offset: #{log_contents.tell}"
            log_file.last_log_offset = filesize
            log_file.save
          end
        else
          puts "Log File doesn't exist!"
        end
      end
      puts "End of server ##{server.id}."
    end
  end
  puts "Finished."
  puts "*********************************\n"
end

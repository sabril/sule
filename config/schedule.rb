# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
RAILS_ROOT = "/usr/local/nginx/html"
# Example:
#
set :output, "#{RAILS_ROOT}/log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, 'production'
every 30.minutes do
  runner "app/controllers/parser_controller.rb"
end
every 1.weeks do 
  rake "log:clear"
end

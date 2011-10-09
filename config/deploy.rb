#$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) 
#require "rvm/capistrano"     
#set :rvm_ruby_string, '1.8.7@rails2'    
set :application, "sifornet"
set :domain, "ec2-184-73-74-45.compute-1.amazonaws.com"
set :user, "ec2-user"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "sabril.pem")]

set :repository,  "git@github.com:/sabril/sifornet.git"
set :scm, :git
set :branch, "master"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                    # Your HTTP server, Apache/etc
role :app, domain                    # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/var/www/rails_app/deploy/#{application}"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :use_sudo, false

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

#ssh_options[:keys] = %w(/Users/syaifulsabril/.ssh/id_rsa)
#ssh_options[:paranoid] = false
#default_run_options[:pty] = true # Ensures prompt for password


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm -rf #{release_path}/tmp/pids"
    run "chmod -R 777 #{release_path}/log"
    #run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  # desc "update crontab"
  # task :update_crontab do
  #   run "cd #{release_path} && bundle exec whenever --update-crontab log_parser"
  # end
  task :bundle_gems do
    run "cd #{current_path} && bundle install"
  end
end
after 'deploy:update_code', 'deploy:symlink_shared'#, 'deploy:bundle_gems'
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sifornet::Application.initialize!
ActionMailer::Base.smtp_settings = { 
  :address => "smtp.gmail.com",	# default: localhost 
  :tls                  => true,
  :port                 => 587,
  :domain               => 'cakrapersada.com', #domain
  :user_name            => 'yudhi@cakrapersada.com', #username email
  :password             => 'd13k03@!', #password email
  :authentication       => 'plain',
  :enable_starttls_auto => true
#  :address => "localhost",
#  :port => 25,
#  :domain => "202.61.104.97"
}

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed {or created alongside the db with db:setup}.
#
# Examples:
#
#   cities = City.create{[{ :name => 'Chicago' }, { :name => 'Copenhagen' }]}
#   Mayor.create{:name => 'Daley', :city => cities.first}

# Create a default user
AdminUser.create!(:email => 'syaiful.sabril@gmail.com', :password => 'Passw0rd', :password_confirmation => 'Passw0rd')
AdminUser.create!(:email => 'admin@sifornet.com', :password => 'admin_sifornet', :password_confirmation => 'admin_sifornet')

#Create status codes
codes = StatusCode.create([{:code => '100', :definition => 'Continue'},
{:code => '101', :definition => 'Switching Protocols'},
{:code => '200', :definition => 'Ok'},
{:code => '201', :definition => 'Created'},
{:code => '202', :definition => 'Accepted'},
{:code => '203', :definition => 'Non-Authoritative Information'},
{:code => '204', :definition => 'No Content'},
{:code => '205', :definition => 'Reset Content'},
{:code => '206', :definition => 'Partial Content'},
{:code => '300', :definition => 'Multiple Choices'},
{:code => '301', :definition => 'Moved Permanently'},
{:code => '302', :definition => 'Found'},
{:code => '303', :definition => 'See Other'},
{:code => '304', :definition => 'Not Modified'},
{:code => '305', :definition => 'Use Proxy'},
{:code => '306', :definition => 'Unused'},
{:code => '307', :definition => 'Temporary Redirect'},
{:code => '400', :definition => 'Bad Request'},
{:code => '401', :definition => 'Unauthorized'},
{:code => '402', :definition => 'Payment Required'},
{:code => '403', :definition => 'Forbidden'},
{:code => '404', :definition => 'Not Found'},
{:code => '405', :definition => 'Method Not Allowed'},
{:code => '406', :definition => 'Not Acceptable'},
{:code => '407', :definition => 'Proxy Authentication Required'},
{:code => '408', :definition => 'Request Timeout'},
{:code => '409', :definition => 'Conflict'},
{:code => '410', :definition => 'Gone'},
{:code => '411', :definition => 'Length Required'},
{:code => '412', :definition => 'Precondition Failed'},
{:code => '413', :definition => 'Request Entity Too Large'},
{:code => '414', :definition => 'Request-URI Too Long'},
{:code => '415', :definition => 'Unsupported Media Type'},
{:code => '416', :definition => 'Requested Range Not Satisfiable'},
{:code => '417', :definition => 'Expectation Failed'},
{:code => '500', :definition => 'Internal Server Error'},
{:code => '501', :definition => 'Not Implemented'},
{:code => '502', :definition => 'Bad Gateway'},
{:code => '503', :definition => 'Service Unavailable'},
{:code => '504', :definition => 'Gateway Timeout'},
{:code => '505', :definition => 'HTTP Version Not Supported'}])


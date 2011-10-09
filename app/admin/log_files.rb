ActiveAdmin.register LogFile do
  #@servers = Server.all
  menu :parent => "Settings"
  #filter :server, :collection => @servers.collect {|d| [d.host_name, d.id]}
  filter :log_type, :as => :select, :collection => ["Squid log", "Radius log"]
  index do
    column :server do |log_file|
      link_to log_file.server.host_name, admin_server_path(log_file.server)
    end
    column :file_path do |log_file|
      log_file.log.path
    end
    column :log_type
    default_actions
  end
  
  # form format
  form :html => {:multipart => true} do |f|
    @servers = Server.all
    #f.error_messages
    f.inputs "Details" do
      f.input :server, :collection => @servers.collect {|d| ["#{d.host_name} - #{d.ip_address}",d.id]}, :include_blank => false
      f.input :log_type, :collection => ["Squid log", "Radius log"], :include_blank => false
      #f.input :file_path
      f.input :log
    end
    f.buttons
  end
  
  # show format
  show do
    @log_file = LogFile.find(params[:id])
    render "log_files/show"
  end
end

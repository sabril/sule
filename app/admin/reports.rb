ActiveAdmin.register Report do

  index do
    column :title
    column :report_type
    column :start_date
    column :end_date
    default_actions
  end
  
  form do |f|
    @servers = Server.all
    f.inputs "Report Details" do
      f.input :title
      f.input :server_id, :include_blank => false, :collection => @servers.collect {|l| [l.host_name,l.id]}
      f.input :log_file, :include_blank => false, :collection => @servers.first.log_files.collect {|l| [l.log_file_name,l.id]}
      f.input :report_type, :as => :select, :collection => ["Top IP Access", "Top Web Visits"], :include_blank => false
      f.input :start_date, :as => :datepicker, :input_html => {:style => "width: 80px;"}
      f.input :end_date, :as => :datepicker, :input_html => {:style => "width: 80px;"}
    end
    f.buttons
  end
  
  show do 
    @report = Report.find(params[:id])
    if @report.report_type == "Top IP Access"
      render "reports/show_top_ip"
    elsif @report.report_type == "Top Web Visits"
      render "reports/show_top_ip"
    end
  end
end

class AjaxController < ApplicationController
  def search_log_file
    @log_files = LogFile.where(:server_id => params[:server_id])
    render :layout => false
  end
end
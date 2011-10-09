class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
    @values = eval(@report.values)
    @ips = Array.new
    @visits = Array.new
    @downloads = Array.new
    for value in @values
      for log_1 in value[0]
        @ips.push log_1[0]
        @visits.push log_1[1]
      end
      for log_2 in value[1]
        @downloads.push (log_2[1].to_i/1024)
      end
    end
    # for value in @values
    #   @ips.push value[0]
    #   @visits.push value[1]
    # end
    @ips = @ips.to_json.gsub('"',"'")
  end

end

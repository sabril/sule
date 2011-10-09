class Traffic < ActiveRecord::Base
  belongs_to :log_file
  def code
    code = self.status_code.split("/")[1]
  end
  
  def code_definition
    status_codes = StatusCode.all.collect {|s| s.code}
    if status_codes.include?(code)
      status = StatusCode.find_by_code(code)
      code_definition = status.definition
    else
      code_definition = "#{code} is Not Defined"
    end
  end
end

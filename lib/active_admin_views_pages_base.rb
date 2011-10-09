class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para "Copyright &copy; #{Date.today.year.to_s} #{link_to('www.inovasi.co.id', 'http://www.inovasi.co.id', :target => '_blank')}. ".html_safe
    end
  end

end
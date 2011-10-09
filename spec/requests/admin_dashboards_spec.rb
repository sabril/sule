require 'spec_helper'
require 'devise/test_helpers'

describe "AdminDashboards" do
  def mock_user(stubs={})
    @mock_user ||= mock_model(AdminUser, {:email => "sabril@gmail.com", :password => "123456"}).as_null_object
  end
  
  describe "GET /admin" do
    it "user login" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #AdminUser.stub(:find).with("37") { mock_user }
      mock_user = Factory.build(:admin_user)
      visit admin_dashboard_path
      page.should have_content("Email")
      page.should have_content("Password")
      puts mock_user.email
      fill_in("Email", :with => mock_user.email)
      fill_in("Password", :with => mock_user.password)
      click_button "Login"
      # save_and_open_page
      # page.should have_content("Signed in successfully.")
    end
  end
end

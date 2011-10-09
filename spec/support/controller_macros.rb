module ControllerMacros
  def login_admin_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin_user]
      sign_in Factory.create(:admin_user)
    end
  end
end
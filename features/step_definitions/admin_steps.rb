Given /^I login as:$/ do |table|
  table.hashes.each do |hash|
    @user = Factory(:admin_user, hash)
  end
     
  And %{I go to the login page}
  And %{I fill in "admin_user_email" with "#{@user.email}"}
  And %{I fill in "admin_user_password" with "#{@user.password}"}
  And %{I press "Login"}
end
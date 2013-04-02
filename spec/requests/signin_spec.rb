require 'spec_helper'

describe "Signin" do
  it "should display page with fields" do
    visit "/signin"
    
    page.status_code.should eql(200)
  end
  
  it "should sign user in with valid credentials" do
    user = FactoryGirl.create(:user)
    identity = FactoryGirl.create(:identity)
    
    visit "/signin"
    
    find("#login-container form").should have_css("#auth_key")
    find("#login-container form").should have_css("#password")
    
    within("#login-container") do
      fill_in "Email", :with => identity.email
      fill_in "Password", :with => "my-password"
    end
    
    page.find(".kd-btn.login-btn").click
    
    page.should have_content("Hi identity")
  end

  
  it "should not sign in using invalid credentials" do
    user = FactoryGirl.create(:user)
    identity = FactoryGirl.create(:identity)
    
    visit "/signin"
    
    within("#login-container") do
      fill_in "Email", :with => identity.email
      fill_in "Password", :with => "this-is-not-my-password"
    end
    
    page.find(".kd-btn.login-btn").click
    
    page.should have_content("Authentication failed, please try again.")
  end
end

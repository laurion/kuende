require 'spec_helper'

describe "Signup" do
  it "should display page with fields" do
    visit "/signup"
    
    page.status_code.should eql(200)
  end
  
  it "should signup user in with valid credentials" do
    visit "/signup"
    
    find("#signup-container form").should have_css("#email")
    find("#signup-container form").should have_css("#password")
    find("#signup-container form").should have_css("#password_confirmation")
    
    within("#signup-container") do
      find("#email").set("a@example.com")
      find("#password").set("my-password")
      find("#password_confirmation").set("my-password")
    end
    
    page.find(".kd-btn.signup-btn").click
    
    page.should have_content("Hi identity")
  end

  it "should not signup user in without matching confirmation" do
    visit "/signup"
    
    within("#signup-container") do
      find("#email").set("a@example.com")
      find("#password").set("my-password")
      find("#password_confirmation").set("my-different-password")
    end
    
    page.find(".kd-btn.signup-btn").click
    page.should have_content("Password confirmation doesn't match Password")
  end
  
  it "should not create user if already exists an account" do
    visit "/signup"
    
    FactoryGirl.create(:identity, email: "a@example.com", password: "my-password")
    
    within("#signup-container") do
      find("#email").set("a@example.com")
      find("#password").set("my-password")
      find("#password_confirmation").set("my-password")
    end
    
    page.find(".kd-btn.signup-btn").click
    page.should have_content("Email has already been taken")
  end 
end

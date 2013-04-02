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

  it "should add user in database" do
    visit "/signup"

    within("#signup-container") do
      find("#email").set("a@example.com")
      find("#password").set("my-password")
      find("#password_confirmation").set("my-password")
    end

    page.find(".kd-btn.signup-btn").click

    Identity.where(email: "a@example.com").size.should eql(1)
    id = Identity.where(email: "a@example.com").first

    User.where(:provider => "identity", :uid => id.id)
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
    FactoryGirl.create(:identity, email: "a@example.com", password: "my-password")

    visit "/signup"
        
    within("#signup-container") do
      find("#email").set("a@example.com")
      find("#password").set("my-password")
      find("#password_confirmation").set("my-password")
    end
    
    page.find(".kd-btn.signup-btn").click
    page.should have_content("Email has already been taken")
  end 
end

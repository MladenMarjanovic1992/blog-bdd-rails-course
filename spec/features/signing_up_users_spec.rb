require "rails_helper"

RSpec.feature "Signing up users" do
  
  scenario "with invalid credentials" do
    
    visit "/"
    click_link "Sign up"
    
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    
    #expect(page).to have_content("You have not signed up successfully.")
    
  end
  
  scenario "with valid credentials" do
    
    visit "/"
    click_link "Sign up"
    
    fill_in "Email", with: "mladen@mladen.com"
    fill_in "Password", with: "zvezdara92"
    fill_in "Password confirmation", with: "zvezdara92"
    click_button "Sign up"
    
    expect(page).to have_content "You have signed up successfully."
    
  end
    
end
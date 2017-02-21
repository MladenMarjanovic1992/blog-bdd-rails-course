require 'rails_helper'

RSpec.feature "Adding comments to Articles" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @article = Article.create(title: "First", body: "Lorem ipsum dolor", user: @john)
    @fred = User.create!(email: "fred@example.com", password: "password")
  end
  
  scenario "permits a signed in user to add comment" do
    
    login_as(@fred)
    visit root_path
    
    click_link @article.title
    fill_in "New comment", with: "An amazing article"
    click_button "Add Comment"
    
    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article.id))
    
  end
  
end
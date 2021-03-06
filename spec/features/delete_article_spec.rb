require 'rails_helper'

RSpec.feature "Deleting Articles" do
  
  before do
    john = User.create!(email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "First", body: "Lorem ipsum dolor", user: john)
  end
  
  scenario "A user deletes an article" do
    visit "/"
    
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content "Article deleted successfully."
    expect(current_path).to eq(articles_path)
  end
end
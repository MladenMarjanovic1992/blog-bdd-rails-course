require "rails_helper"

RSpec.feature "Showing an article" do
  
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @article = Article.create(title: "First", body: "Lorem ipsum dolor", user: @john)
    @fred = User.create!(email: "fred@example.com", password: "password")
  end
  
  scenario "to non-signed-in used hide edit and delete buttons" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit article")
    expect(page).not_to have_link("Delete Article")

  end
  
  scenario "to non-owner used hide edit and delete buttons" do
    login_as(@fred)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit article")
    expect(page).not_to have_link("Delete Article")

  end
  
  scenario "to signed-in used show edit and delete buttons" do
    login_as(@john)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit article")
    expect(page).to have_link("Delete Article")

  end
  
end
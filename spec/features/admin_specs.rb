require 'rails_helper'

describe 'User can be admin' do

  before :each do
    visit "/"
    @user = User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass', admin: true)
    Project.create(name: "My sweet project")

    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

  end

  scenario "User is admin" do

    expect(page).to have_content('My sweet project')

  end

  scenario "Admin user can see all projects" do
    Project.create(name: "My sweet project")

    visit '/projects'

    expect(page).to have_content 'My sweet project'
  end

  scenario "Admins can create other admin user" do
    visit '/users'
    click_on "New User"

    expect(page).to have_content('Admin')

  end

end

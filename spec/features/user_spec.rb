require 'rails_helper'

describe 'User can CRUD new user' do

  before :each do
    visit '/'
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass')
    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

    expect(page).to have_content("TestFirstName")
    click_on "Projects"
    click_on "Users"
  end

  scenario 'User can create new user' do

    click_on "New User"
    expect(page).to have_content("New User")

    fill_in 'user[first_name]', :with => "TestFirstName"
    fill_in 'user[last_name]', :with => "TestLastName"
    fill_in 'user[email]', :with => "Test2@email.com"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypass"


    click_on "Create User"
    expect(page).to have_content("User was successfully created.")
  end

  scenario 'User can view user show page' do
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com')

    visit "users"

    click_on 'TestFirstName'
    expect(page).to have_content("TestFirstName TestLastName")
    expect(page).to have_content("Test@email.com")

  end

  scenario 'User can edit user from show page' do
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com')

    visit "users"

    click_on 'TestFirstName'
    expect(page).to have_content("TestFirstName TestLastName")
    expect(page).to have_content("Test@email.com")

    click_on "Edit"
    expect(page).to have_content("Edit User")

    fill_in 'user[first_name]', :with => "TestFirstNameEdit"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypass"
    click_on "Update User"

    expect(page).to have_content("TestFirstNameEdit")
    expect(page).to have_content("User was successfully updated.")
  end

  scenario 'User can delete user' do
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com')

    visit "users"

    click_on "Delete"
    expect(page).to have_content("User was successfully deleted.")
    expect(page).to have_no_content("TestFirstName")
  end

end

require 'rails_helper'

describe 'User can CRUD new user' do

  before :each do
    visit '/'
    click_on "Users"
  end

  scenario 'User can create new user' do

    click_on "New User"
    expect(page).to have_content("New User")

    fill_in 'user[first_name]', :with => "TestFirstName"
    fill_in 'user[last_name]', :with => "TestLastName"
    fill_in 'user[email]', :with => "Test@email.com"

    click_on "Create User"
    expect(page).to have_content("User was successfully created.")
    expect(page).to have_content("TestFirstName")
    expect(page).to have_content("TestLastName")
    expect(page).to have_content("Test@email.com")
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

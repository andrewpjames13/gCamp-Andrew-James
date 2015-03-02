require 'rails_helper'

describe 'User can sign up' do

  before :each do
    visit "/"
  end

  scenario "User can sign up with valid cradentials" do
    click_on "Sign Up"

    fill_in 'First name', :with => "TestFirstName"
    fill_in 'Last name', :with => "TestLastName"
    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypass"

    click_button 'Sign Up'

    expect(page).to have_content("TestFirstName")
  end

  scenario "User can not sign up without confirming password" do

    click_on "Sign Up"

    fill_in 'First name', :with => "TestFirstName"
    fill_in 'Last name', :with => "TestLastName"
    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypassnot"
    click_button 'Sign Up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "User can not sign up with same eamil as other user" do
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@test.com', :password => 'mypass', :password_confirmation => 'mypass')

    click_on "Sign Up"

    fill_in 'First name', :with => "NewFirst"
    fill_in 'Last name', :with => "NewLast"
    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypass"
    click_button 'Sign Up'

    expect(page).to have_content("Email has already been taken")

  end


end

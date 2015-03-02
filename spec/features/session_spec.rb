require 'rails_helper'

describe 'User can sign in' do

  before :each do
    visit "/"
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@test.com', :password => 'mypass', :password_confirmation => 'mypass')

  end

  scenario "User can sign in with valid cradentials" do

    click_on "Sign In"

    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "mypass"

    click_button 'Sign In'

    expect(page).to have_content("Welcome")

  end

  scenario "User can not sign in with wrong password" do

    click_on "Sign In"

    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "blahblahblahblah"

    click_button 'Sign In'

    expect(page).to have_content("Email / password combination invalid")

  end

  scenario "User can sign out" do
    click_on "Sign In"

    fill_in 'Email', :with => "Test@test.com"
    fill_in 'Password', :with => "mypass"

    click_button 'Sign In'

    expect(page).to have_content("Welcome")

    click_on "Sign Out"

    expect(page).to have_content("Successfully Logged out!")

  end

end

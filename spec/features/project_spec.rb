require 'rails_helper'

describe 'User can CRUD new project' do

  before :each do
    visit "/"
    @user = User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass')

    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

    expect(page).to have_content("TestFirstName")

  end

  scenario "User can create a new Project" do

    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

  end

  scenario "User can view project show page" do
    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".breadcrumb") do
      click_link('TestName')
    end

    expect(page).to have_content("TestName")

  end

  scenario "User can edit a project" do
    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".breadcrumb") do
      click_link('TestName')
    end

    expect(page).to have_content("TestName")


    within(".pull-right") do
      click_link('Edit')
    end


    expect(page).to have_content("TestName")
  end

  scenario "User can delete a project" do
    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".breadcrumb") do
      click_link('TestName')
    end

    expect(page).to have_content("TestName")


    within(".well") do
      click_link('Delete')
    end
  end

end

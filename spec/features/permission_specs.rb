require 'rails_helper'

describe 'User has limited access' do

  before :each do
    visit "/"
    @user = User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass')

    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

  end

  scenario "User redirected to project index after login" do

    expect(page).to have_content("TestFirstName")
    expect(page).to have_content("Projects")

  end

  scenario "User redirected to New Project after sign up" do
    click_on "Sign Out"

    click_on "Sign Up"

    fill_in 'user[first_name]', :with => "TestFirstName"
    fill_in 'user[last_name]', :with => "TestLastName"
    fill_in 'user[email]', :with => "Test2@email.com"
    fill_in 'Password', :with => "mypass"
    fill_in 'Password confirmation', :with => "mypass"

    click_button "Sign Up"

    expect(page).to have_content("TestFirstName")
    expect(page).to have_content("Create Project")

  end

  scenario "User creates a project they become an owner" do

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

    click_on "1 Memberships"

    expect(page).to have_content("Owner")
  end

  scenario "User creates a project they are redirected to the task index page" do

    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")
    expect(page).to have_content("Tasks for TestName")

  end

  scenario "User can only see projects they are a member of" do

    Project.create!(name: "Cant see this")

    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".breadcrumb") do
      click_link('Projects')
    end
    expect(page).to_not have_content("Cant see this")
    expect(page).to have_content("TestName")
  end

  scenario "User can only manage tasks they are members of" do
    @project = Project.create(name: "My sweet project")

    visit (project_tasks_path(@project))

    expect(page).to have_content("You do not have access to that project")

  end

  scenario "User can only manage memberships they are members of" do
    @project = Project.create(name: "My sweet project")
    @permuser = User.create(:first_name => "permFirstName", :last_name => 'permLastName', :email => 'perm@email.com', :password => 'mypass', :password_confirmation => 'mypass')
    @membership = Membership.create!(project_id: @project.id, user_id: @permuser.id, role: "member" )

    visit (project_memberships_path(@project, @membership))

    expect(page).to have_content("You do not have access to that project")

  end

  scenario "Only project owner can edit projects" do

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
    expect(page).to have_content("1 Memberships")

    within(".pull-right") do
      click_link('Edit')
    end

    fill_in 'project[name]', :with => "TestNameEdit"
    click_on "Update Project"
    expect(page).to have_content("Project was successfully updated.")
    expect(page).to have_content("TestNameEdit")

  end

  scenario 'User can go to membership its not a member of' do
    @project = Project.create(name: 'TestName')
    visit project_memberships_path(@project)
    expect(page).to have_content 'You do not have access to that project'
  end

  scenario "User can delete their own membership" do
    @project = Project.create(name: "My sweet project")
    @permuser = User.create(:first_name => "permFirstName", :last_name => 'permLastName', :email => 'perm@email.com', :password => 'mypass', :password_confirmation => 'mypass')
    @membership = Membership.create(project_id: @project.id, user_id: @permuser.id, role: "owner" )
    Membership.create(project_id: @project.id, user_id: @user.id, role: "member" )

    visit (project_memberships_path(@project, @membership))

    expect(page).to have_content("My sweet project: Manage Members")

    find('a[data-method = "delete"]').click

  end

  scenario "Last owner of membership can not be deleted" do

    @project = Project.create(name: "My sweet project")
    @membership = Membership.create(project_id: @project.id, user_id: @user.id, role: "owner" )

    visit (project_memberships_path(@project, @membership))

    expect(page).to have_content("My sweet project: Manage Members")

    first('select[name = "membership[role]"]').find('option[value = "member"]').select_option
    first('input[name = "commit"]').click
  end

  # scenario 'Logged in user can only edit their own user' do
  #
  #   click_on 'Users'
  #
  #   expect(page).to have_content('Users')
  #
  #   find('.clickable-text', :text => 'Edit').click
  #
  # end

  scenario 'Users cannot see email addresses of other users' do
  @permuser = User.create(:first_name => "permFirstName", :last_name => 'permLastName', :email => 'perm@email.com', :password => 'mypass', :password_confirmation => 'mypass')

  click_on 'Users'

  expect(page).to have_content('Test@email.com')
  expect(page).to_not have_content('perm@email.com')

  end

  scenario "Non admin user can not see all projects" do
    Project.create(name: "My sweet project")
    Project.create(name: "More project")

    visit '/projects'

    expect(page).to_not have_content 'My sweet project'
    expect(page).to_not have_content 'More project'
  end

  scenario "Users cannot create admin users" do
      visit '/users'
      click_on "New User"
      expect(page).to_not have_content 'Admin'
    end



end

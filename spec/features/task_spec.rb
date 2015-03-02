require 'rails_helper'

describe 'User can CRUD new task' do

  before :each do
    visit "/"
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass')
    Project.create(:name => "TestProject")

    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

    expect(page).to have_content("TestFirstName")
    click_on "Projects"

  end

  scenario "User can create new task" do
    click_on "0"

    click_on "New Task"
    expect(page).to have_content("New Task")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")

  end

  scenario "User can visit task show page" do

    click_on "0"

    click_on "New Task"
    expect(page).to have_content("New Task")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")

    visit "/projects"

    click_on "1"
    expect(page).to have_content("Tasks for TestProject")

    click_on "Show"
    expect(page).to have_content("TestDescription")

  end

  scenario "User can edit task" do
    click_on "0"

    click_on "New Task"
    expect(page).to have_content("New Task")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")

    visit "/projects"

    click_on "1"
    expect(page).to have_content("Tasks for TestProject")

    click_on "Edit"

    fill_in 'task[description]', :with => "TestDescriptionEdit"
    click_on "Update Task"

    expect(page).to have_content("Task was successfully updated.")

  end

  scenario "User can delete task" do
    click_on "0"

    click_on "New Task"
    expect(page).to have_content("New Task")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")

    visit "/projects"

    click_on "1"
    expect(page).to have_content("Tasks for TestProject")
  
    click_on "Delete"
    expect(page).to have_content("Task was successfully destroyed.")

  end

end

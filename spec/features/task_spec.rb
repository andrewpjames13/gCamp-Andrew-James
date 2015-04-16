require 'rails_helper'

describe 'User can CRUD new task' do

  before :each do
    visit "/"
    User.create(:first_name => "TestFirstName", :last_name => 'TestLastName', :email => 'Test@email.com', :password => 'mypass', :password_confirmation => 'mypass')

    click_on "Sign In"
    expect(page).to have_content("Sign into gCamp")

    fill_in 'Email', :with => "Test@email.com"
    fill_in 'Password', :with => "mypass"
    click_button "Sign In"

    expect(page).to have_content("TestFirstName")

  end

  scenario "User can create new task" do
    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".pull-right") do
      click_link('New Task')
    end

    expect(page).to have_content("TestName")

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

    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".pull-right") do
      click_link('New Task')
    end

    expect(page).to have_content("TestName")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")
  end

  scenario "User can edit task" do
    within(".pull-right") do
      click_link('New Project')
    end

    expect(page).to have_content("Create Project")

    fill_in 'project[name]', :with => "TestName"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created!")
    expect(page).to have_content("TestName")

    within(".pull-right") do
      click_link('New Task')
    end

    expect(page).to have_content("TestName")

    fill_in 'task[description]', :with => "TestDescription"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("2015/01/15")

    within(".pull-right") do
      click_link('Edit')
    end

    expect(page).to have_content("Editing Task")

    fill_in 'task[description]', :with => "TestDescriptionEdit"
    select '2015', :from => "task_due_date_1i"
    select 'January', :from => "task_due_date_2i"
    select '15', :from => "task_due_date_3i"

    click_button('Update Task')

  end

  scenario "User can delete task" do

        within(".pull-right") do
          click_link('New Project')
        end

        expect(page).to have_content("Create Project")

        fill_in 'project[name]', :with => "TestName"
        click_on "Create Project"
        expect(page).to have_content("Project was successfully created!")
        expect(page).to have_content("TestName")

        within(".pull-right") do
          click_link('New Task')
        end

        expect(page).to have_content("TestName")

        fill_in 'task[description]', :with => "TestDescription"
        select '2015', :from => "task_due_date_1i"
        select 'January', :from => "task_due_date_2i"
        select '15', :from => "task_due_date_3i"

        click_on "Create Task"
        expect(page).to have_content("Task was successfully created.")
        expect(page).to have_content("TestDescription")
        expect(page).to have_content("2015/01/15")

        within(".breadcrumb") do
          click_link('Tasks')
        end

        click_on("delete-link")
    # expect(page).to have_content("Task was successfully destroyed.")

  end

end

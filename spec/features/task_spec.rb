require 'rails_helper'

describe 'User can CRUD new task' do

  before :each do
    visit "/"
    click_on "Tasks"
  end

  scenario "User can create new task" do
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
    Task.create(:description => "TestDescription")

    visit "tasks"

    click_on "TestDescription"
    expect(page).to have_content("TestDescription")
  end

  scenario "User can edit task" do
    Task.create(:description => "TestDescription")

    visit "tasks"

    click_on "Edit"
    expect(page).to have_content("Editing Task")

    fill_in 'task[description]', :with => "TestEdit"
    click_on "Update Task"
    expect(page).to have_content("Task was successfully updated.")
  end

  scenario "User can delete task" do
    Task.create(:description => "TestDescription")

    visit "tasks"

    click_on "Delete"
    expect(page).to have_content("Task was successfully destroyed.")

  end

end

require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "should create task" do
    visit tasks_url
    click_on "New task"

    fill_in "Duration", with: @task.duration
    fill_in "End date", with: @task.end_date
    fill_in "Parent unique", with: @task.parent_unique_id
    fill_in "Project", with: @task.project_id
    fill_in "Start date", with: @task.start_date
    fill_in "Task description", with: @task.task_description
    fill_in "Task name", with: @task.task_name
    fill_in "Task type", with: @task.task_type_id
    fill_in "Unique task", with: @task.unique_task_id
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "should update Task" do
    visit task_url(@task)
    click_on "Edit this task", match: :first

    fill_in "Duration", with: @task.duration
    fill_in "End date", with: @task.end_date
    fill_in "Parent unique", with: @task.parent_unique_id
    fill_in "Project", with: @task.project_id
    fill_in "Start date", with: @task.start_date
    fill_in "Task description", with: @task.task_description
    fill_in "Task name", with: @task.task_name
    fill_in "Task type", with: @task.task_type_id
    fill_in "Unique task", with: @task.unique_task_id
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "should destroy Task" do
    visit task_url(@task)
    click_on "Destroy this task", match: :first

    assert_text "Task was successfully destroyed"
  end
end

require "application_system_test_case"

class TaskTypesTest < ApplicationSystemTestCase
  setup do
    @task_type = task_types(:one)
  end

  test "visiting the index" do
    visit task_types_url
    assert_selector "h1", text: "Task types"
  end

  test "should create task type" do
    visit task_types_url
    click_on "New task type"

    fill_in "Name", with: @task_type.name
    click_on "Create Task type"

    assert_text "Task type was successfully created"
    click_on "Back"
  end

  test "should update Task type" do
    visit task_type_url(@task_type)
    click_on "Edit this task type", match: :first

    fill_in "Name", with: @task_type.name
    click_on "Update Task type"

    assert_text "Task type was successfully updated"
    click_on "Back"
  end

  test "should destroy Task type" do
    visit task_type_url(@task_type)
    click_on "Destroy this task type", match: :first

    assert_text "Task type was successfully destroyed"
  end
end

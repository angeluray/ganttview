require "application_system_test_case"

class DiagramsTest < ApplicationSystemTestCase
  setup do
    @diagram = diagrams(:one)
  end

  test "visiting the index" do
    visit diagrams_url
    assert_selector "h1", text: "Diagrams"
  end

  test "should create diagram" do
    visit diagrams_url
    click_on "New diagram"

    fill_in "Description", with: @diagram.description
    fill_in "Duration", with: @diagram.duration
    fill_in "End date", with: @diagram.end_date
    fill_in "Parent", with: @diagram.parent
    fill_in "Priority", with: @diagram.priority
    fill_in "Progress", with: @diagram.progress
    fill_in "Start date", with: @diagram.start_date
    fill_in "Task name", with: @diagram.task_name
    click_on "Create Diagram"

    assert_text "Diagram was successfully created"
    click_on "Back"
  end

  test "should update Diagram" do
    visit diagram_url(@diagram)
    click_on "Edit this diagram", match: :first

    fill_in "Description", with: @diagram.description
    fill_in "Duration", with: @diagram.duration
    fill_in "End date", with: @diagram.end_date
    fill_in "Parent", with: @diagram.parent
    fill_in "Priority", with: @diagram.priority
    fill_in "Progress", with: @diagram.progress
    fill_in "Start date", with: @diagram.start_date
    fill_in "Task name", with: @diagram.task_name
    click_on "Update Diagram"

    assert_text "Diagram was successfully updated"
    click_on "Back"
  end

  test "should destroy Diagram" do
    visit diagram_url(@diagram)
    click_on "Destroy this diagram", match: :first

    assert_text "Diagram was successfully destroyed"
  end
end

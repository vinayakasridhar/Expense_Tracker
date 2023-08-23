require "application_system_test_case"

class ExpenseReportsTest < ApplicationSystemTestCase
  setup do
    @expense_report = expense_reports(:one)
  end

  test "visiting the index" do
    visit expense_reports_url
    assert_selector "h1", text: "Expense reports"
  end

  test "should create expense report" do
    visit expense_reports_url
    click_on "New expense report"

    fill_in "Title", with: @expense_report.title
    fill_in "Total amount", with: @expense_report.total_amount
    fill_in "User", with: @expense_report.user_id
    click_on "Create Expense report"

    assert_text "Expense report was successfully created"
    click_on "Back"
  end

  test "should update Expense report" do
    visit expense_report_url(@expense_report)
    click_on "Edit this expense report", match: :first

    fill_in "Title", with: @expense_report.title
    fill_in "Total amount", with: @expense_report.total_amount
    fill_in "User", with: @expense_report.user_id
    click_on "Update Expense report"

    assert_text "Expense report was successfully updated"
    click_on "Back"
  end

  test "should destroy Expense report" do
    visit expense_report_url(@expense_report)
    click_on "Destroy this expense report", match: :first

    assert_text "Expense report was successfully destroyed"
  end
end

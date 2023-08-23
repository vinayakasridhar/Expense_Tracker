require "test_helper"

class ExpenseReportControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get expense_report_new_url
    assert_response :success
  end

  test "should get create" do
    get expense_report_create_url
    assert_response :success
  end

  test "should get show" do
    get expense_report_show_url
    assert_response :success
  end
end

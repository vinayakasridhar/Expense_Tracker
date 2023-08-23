class AddUserToExpenseReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :expense_reports, :user, foreign_key: true
  end
end

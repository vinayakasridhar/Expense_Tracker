class AddExpenseReportReferenceToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :expense_report, foreign_key: true
  end
end

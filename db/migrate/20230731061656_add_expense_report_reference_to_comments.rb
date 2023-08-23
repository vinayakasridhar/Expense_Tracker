class AddExpenseReportReferenceToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :expense_report, foreign_key: true
  end
end

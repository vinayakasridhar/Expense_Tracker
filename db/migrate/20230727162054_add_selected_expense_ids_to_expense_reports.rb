class AddSelectedExpenseIdsToExpenseReports < ActiveRecord::Migration[7.0]
  def change
    add_column :expense_reports, :selected_expense_ids, :integer, array: true, default: []
  end
end

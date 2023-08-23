class AddColumnsToExpenseReport < ActiveRecord::Migration[7.0]
  def change
    add_column :expense_reports, :title, :string
    add_column :expense_reports, :total_amount, :decimal
  end
end

class ChangeExpenseIdNullConstraintInComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :expense_id, true
  end
end

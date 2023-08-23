class AddDefaultToExpenses < ActiveRecord::Migration[7.0]
  def change
    change_column_default :expenses, :approval_status, from: nil, to: "pending"
  end
end

class AddApprovalStatusToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :approval_status, :string, default: "pending"
  end
end

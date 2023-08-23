class UpdateApprovalStatusToExpenses < ActiveRecord::Migration[7.0]
  def change
    Expense.where(approval_status: nil).update_all(approval_status: "pending")
  end
end

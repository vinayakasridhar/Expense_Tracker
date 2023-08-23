class ChangeDefaultEmploymentStatusInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :employment_status, true
  end
end

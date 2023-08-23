class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :department, :string
    add_column :users, :employment_status, :boolean
  end
end

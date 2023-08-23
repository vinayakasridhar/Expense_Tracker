class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.date :date
      t.text :description
      t.decimal :amount
      t.integer :invoice_number
      t.boolean :invoice_validated
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

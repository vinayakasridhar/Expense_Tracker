json.extract! expense, :id, :date, :description, :amount, :invoice_number, :invoice_validated, :user_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)

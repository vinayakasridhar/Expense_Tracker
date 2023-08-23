json.extract! expense_report, :id, :title, :total_amount, :user_id, :created_at, :updated_at
json.url expense_report_url(expense_report, format: :json)

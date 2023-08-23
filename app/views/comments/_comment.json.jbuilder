json.extract! comment, :id, :content, :commentable_type, :expense_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)

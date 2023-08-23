class Comment < ApplicationRecord
  belongs_to :expense_report, optional: true
  belongs_to :expense, optional: true
  belongs_to :user
end

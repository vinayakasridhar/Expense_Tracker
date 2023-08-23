class Expense < ApplicationRecord
  belongs_to :expense_report, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :invoice

  # after_create_commit :validate_invoice
  # attr_accessible :approval_status
end

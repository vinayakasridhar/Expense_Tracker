class ExpenseReport < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :nullify
  has_many :comments, dependent: :destroy
end

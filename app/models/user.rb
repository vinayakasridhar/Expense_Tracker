class User < ApplicationRecord
  has_many :comments
  has_many :expenses
  has_many :expense_reports
  # attr_accessor :name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def get_expenses
    if self.admin
      return Expense.all
    else
      return self.expenses
    end
  end
  def get_expense_reports
    if self.admin
      return ExpenseReport.all
    else
      return self.expense_reports
    end
  end
  
end

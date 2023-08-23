class UserMailer < ApplicationMailer
    default from: 'test@yopmail.com'
  
    def approval_email(expense)
      @expense = expense
      mail(to: @expense.user.email, subject: 'Expense Approved')
    end
  
    def rejection_email(expense)
      @expense = expense
      mail(to: @expense.user.email, subject: 'Expense Rejected')
    end
  
    def comment_email(expense, comment)
      @expense = expense
      @comment = comment
      mail(to: @expense.user.email, subject: 'New Comment on Your Expense')
    end
end
  
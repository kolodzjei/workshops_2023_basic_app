class UserMailer < ApplicationMailer
  def loan_created_email(book_loan)
    @title = book_loan.book.title
    @due_date = book_loan.due_date

    mail(to: book_loan.user.email, subject: 'Book loan')
  end

  def due_date_notification_email(book_loan)
    @title = book_loan.book.title
    @due_date = book_loan.due_date

    mail(to: book_loan.user.email, subject: 'Book loan due date')
  end
end

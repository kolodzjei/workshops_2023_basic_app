class DueDateNotificationJob
  include Sidekiq::Job

  def perform
    # @book_loans = BookLoan.where(status: 'checked_out', due_date: Date.tomorrow)
    book_loans = BookLoan.where(status: 'checked_out', due_date: Time.zone.now..Time.zone.now + 15.minutes)

    book_loans.each do |book_loan|
      UserMailer.due_date_notification_email(book_loan).deliver_now
    end
  end
end

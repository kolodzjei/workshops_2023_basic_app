class LoanCreatedJob
  include Sidekiq::Job

  def perform(id)
    book_loan = BookLoan.find_by(id:)

    UserMailer.loan_created_email(book_loan).deliver_now
  end
end

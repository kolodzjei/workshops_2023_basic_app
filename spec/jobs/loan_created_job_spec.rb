require "rails_helper"

RSpec.describe LoanCreatedJob, type: :job do
  describe "#perform" do
    let(:book_loan) { FactoryBot.create(:book_loan) }

    it "sends an email" do
      expect {
        LoanCreatedJob.new.perform(book_loan.id)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
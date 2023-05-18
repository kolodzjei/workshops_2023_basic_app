require 'rails_helper'

RSpec.describe DueDateNotificationJob, type: :job do
  context 'when the due date is in the future' do
    it 'does not send an email' do
      FactoryBot.create(:book_loan, due_date: 1.year.from_now)
      expect do
        described_class.new.perform
      end.to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end

  context 'when the due date is in 2 minutes' do
    it 'sends an email' do
      FactoryBot.create(:book_loan, due_date: 2.minutes.from_now)
      expect do
        described_class.new.perform
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end

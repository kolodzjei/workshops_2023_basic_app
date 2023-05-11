class UserCalendarNotifier
  include GoogleCalendarClient

  CALENDAR_ID = 'primary'.freeze

  def initialize(user, book_loan)
    @user = user
    @book_loan = book_loan
  end

  def insert_event
    return unless user.token.present? && user.refresh_token.present?

    event = google_calendar_client.insert_event(CALENDAR_ID, event_data)
    set_event_id_in_book_loan(event.id) if event.present?
  end

  private

  attr_reader :user, :book_loan

  def set_event_id_in_book_loan(event_id)
    book_loan.update(calendar_event_id: event_id)
  end

  def event_data
    {
      summary: "Oddaj: #{book.title}",
      description: "Mijja termin oddania książki: #{book.title}",
      start: {
        date_time: two_week_from_now.to_datetime.to_s
      },
      end: {
        date_time: (two_week_from_now + 1.hour).to_datetime.to_s
      }
    }
  end

  def two_week_from_now
    @two_week_from_now ||= Time.zone.now + 2.weeks
  end

  def book
    @book ||= book_loan.book
  end
end

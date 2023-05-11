class CalendarEventRemover
  include GoogleCalendarClient

  CALENDAR_ID = 'primary'.freeze

  def initialize(user, event_id)
    @user = user
    @event_id = event_id
  end

  def remove_event
    return unless user.token.present? && user.refresh_token.present?

    google_calendar_client.delete_event(CALENDAR_ID, event_id)
  end

  private

  attr_reader :user, :event_id
end

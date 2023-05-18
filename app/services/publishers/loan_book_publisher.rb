module Publishers
  class LoanBookPublisher
    def initialize(message)
      @message = message
    end

    def publish
      Publishers::Application.new(
        message:,
        exchange_name: 'basic_app',
        routing_key: 'basic_app.book_loans'
      ).perform
    end

    private

    attr_reader :message
  end
end

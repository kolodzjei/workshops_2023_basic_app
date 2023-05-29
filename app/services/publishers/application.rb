require 'bunny'

module Publishers
  class Application
    def initialize(message:, exchange_name:, routing_key:)
      @message = message
      @exchange_name = exchange_name
      @routing_key = routing_key
    end

    def perform
      connection.start
      channel = connection.create_channel
      exchange = channel.direct(exchange_name)
      exchange.publish(message.to_json, routing_key:)
      connection.close
    end

    private

    attr_reader :message, :exchange_name, :routing_key

    def connection_options
      {
        host: A9n.rabbit_host,
        port: A9n.rabbit_port,
        vhost: A9n.rabbit_vhost,
        username: A9n.rabbit_username,
        password: A9n.rabbit_password
      }
    end

    def connection
      @connection ||= Bunny.new(connection_options)
    end
  end
end

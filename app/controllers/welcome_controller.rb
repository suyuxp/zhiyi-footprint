require "amqp"

class WelcomeController < ApplicationController
  def index
    puts "[request] Sending a request..."

    reply_q = WelcomeController.replies_queue

    WelcomeController.channel.default_exchange.publish("get.time",
      :routing_key => "amqpgem.examples.services.time",
      :message_id  => Kernel.rand(10101010).to_s,
      :reply_to    => reply_q.name)

    reply_q.subscribe do |metadata, payload|
      puts "[response] Response for #{metadata.correlation_id}: #{payload.inspect}"
      @message = payload.inspect

      render text: @message
      rendered_response = response.prepare!
      request.env['async.callback'].call(rendered_response)
    end

    throw :async
  end

  def self.channel
    @channel ||= AMQP::Channel.new(AMQP.connection)
  end

  def self.replies_queue
    @replies_queue = channel.queue("reply-" + Kernel.rand(10101010).to_s, :exclusive => true, :auto_delete => true)
  end
end

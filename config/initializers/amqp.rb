require 'amqp'

EventMachine.next_tick do
  AMQP.connection = AMQP.connect 'amqp://guest:guest@localhost'
  Signal.trap("INT") { AMQP.connection.close { EventMachine.stop } }
end

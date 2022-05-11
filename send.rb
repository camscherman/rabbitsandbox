require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue("hello")

channel.default_exchange.publish("Hello world!", routing_key: queue.name)

puts "Sent 'Hello world'"

connection.close


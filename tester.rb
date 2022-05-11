require 'bunny'

conn = Bunny.new(:host => "rabbit.local")
conn.start

ch = conn.create_channel
ch.confirm_select

q = ch.queue("test1")
q.subscribe(manual_ack: true) do |delivery_info, metadata, payload|
  puts "Received message: #{payload}"
  ch.ack(delivery_info.delivery_tag)
end

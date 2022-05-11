require "bunny"

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)
message_count = 0
begin
  puts "Waiting for messages -- press CTRL+C to quit"
  queue.subscribe(block: true, manual_ack: true) do |delivery_info, _properties, body|
    message_count += 1
    puts "[x] Received #{body} - Message count #{message_count}"
    sleep body.count(".").to_i
    puts "[x] Done"
    channel.ack(delivery_info.delivery_tag)
  end
  
rescue Interrupt => _
  connection.close
  exit(0)
end
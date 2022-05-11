require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

begin
  puts "Waiting for messages -- press CTRL+C to quit"
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts "[x] Received #{body}"
  end
  
rescue Interrupt => _
  connection.close
  exit(0)
end
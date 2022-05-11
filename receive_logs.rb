require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout("logs")

queue = channel.queue('', exclusive: true)

queue.bind(exchange)

puts "[*] Waiting for logs"

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts "[x] #{body}"
  end
  
rescue Interrupt => _
  channel.close
  connection.close
  exit(0)
end
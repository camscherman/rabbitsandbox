require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel

queue = channel.queue("task_queue", durable: true)

message = ARGV.empty? ? "Hello world" : ARGV.join(" ")
10.times do
  queue.publish(message + ("." * ([1,2,3,4,5].sample)), persistent: true)

  puts "Sent '#{message}"
end

connection.close



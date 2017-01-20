require "./conference_room/*"
require "http/server"

port = ENV["PORT"]? || 8080
bind_address = "0.0.0.0"

server = HTTP::Server.new(bind_address, port.to_i) do |context|
  context.response.content_type = "text/plain"
  context.response.print ConferenceRoom::AvailabilityFile.to_text
end

puts "Listening on http://#{bind_address}:#{port}"
server.listen

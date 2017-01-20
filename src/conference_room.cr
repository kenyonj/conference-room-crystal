require "./conference_room/calendar_ids"
require "./conference_room/*"
require "http/server"

port = ARGV.shift? || 8080

server = HTTP::Server.new(port.to_i) do |context|
  context.response.content_type = "text/plain"
  context.response.print ConferenceRoom::AvailabilityFile.to_text
end

puts "Listening on http://127.0.0.1:8080"
server.listen

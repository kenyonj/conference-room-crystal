require "../../spec_helper"

describe ConferenceRoom::IcalResponse do
  it "skips the calendar metadata and only returns events" do
    parser.new(raw_calendar).parse.size.should eq 2
  end
end

private def parser
  ConferenceRoom::IcalResponse
end

private def raw_calendar
  <<-CALENDAR
  BEGIN:VCALENDAR
  PRODID:-//Google Inc//Google Calendar 70.9054//EN
  VERSION:2.0
  CALSCALE:GREGORIAN
  METHOD:PUBLISH
  X-WR-TIMEZONE:America/Los_Angeles
  BEGIN:VEVENT
  DTSTART:20170119T210000Z
  DTEND:20170119T211500Z
  END:VEVENT
  BEGIN:VEVENT
  DTSTART:20170118T210000Z
  DTEND:20170118T214500Z
  END:VEVENT
  CALENDAR
end

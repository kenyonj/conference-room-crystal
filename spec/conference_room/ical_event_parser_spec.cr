require "../../spec_helper"

describe ConferenceRoom::IcalEventParser do
  it "parses the start time" do
    parser.new(raw_event).start_time.should eq Time.new(2017, 1, 19, 21, 0, 0)
  end

  it "parses the end time" do
    parser.new(raw_event).end_time.should eq Time.new(2017, 1, 19, 21, 15, 0)
  end
end

private def parser
  ConferenceRoom::IcalEventParser
end

private def raw_event
  <<-EVENT
  DTSTART:20170119T210000Z
  DTEND:20170119T211500Z
  END:VEVENT
  EVENT
end

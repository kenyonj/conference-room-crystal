class ConferenceRoom::IcalResponse
  EVENT_DELIMITER = "BEGIN:VEVENT"

  getter :raw_calendar

  def initialize(@raw_calendar : String)
  end

  def self.parse(raw_calendar)
    new(raw_calendar).parse
  end

  def parse
    raw_events.map do |raw_event|
      event = IcalEventParser.new(raw_event)
      CalendarEvent.new(start_time: event.start_time, end_time: event.end_time)
    end
  end

  private def raw_events
    raw_calendar.split(EVENT_DELIMITER).skip(calendar_metadata_position)
  end

  private def calendar_metadata_position
    1
  end
end

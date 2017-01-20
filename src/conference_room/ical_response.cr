class ConferenceRoom::IcalResponse
  getter :raw_calendar

  def initialize(@raw_calendar : String)
  end

  def self.parse(raw_calendar)
    new(raw_calendar).parse
  end

  def parse
    raw_events.map do |raw_event|
      event = EventParser.new(raw_event)

      CalendarEvent.new(start_time: event.start_time, end_time: event.end_time)
    end
  end

  private def raw_events
    raw_calendar.split("BEGIN:VEVENT").skip(calendar_metadata)
  end

  private def calendar_metadata
    1
  end
end

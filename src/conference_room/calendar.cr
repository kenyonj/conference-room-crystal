require "http/client"

class ConferenceRoom::Calendar
  getter :name

  def initialize(@name : Symbol)
  end

  def busy_code
    if has_event_happening_now?
      "0"
    else
      "1"
    end
  end

  private def has_event_happening_now?
    events.any? &.happening_now?
  end

  private def events
    IcalResponse.parse(raw_events)
  end

  private def raw_events
    HTTP::Client.get(calendar_url).body
  end

  private def calendar_url
    String.build do |url|
      url << "https://calendar.google.com/calendar/ical/"
      url << CALENDAR_IDS[name]
      url << "@resource.calendar.google.com"
      url << "/public/basic.ics"
    end
  end
end

require "http/client"

class ConferenceRoom::Calendar
  CALENDAR_IDS = {
    bender: ENV["BENDER_ID"],
    optimus: ENV["OPTIMUS_ID"],
    eve: ENV["EVE_ID"],
    walle: ENV["WALLE_ID"],
  }

  getter :name

  def initialize(@name : Symbol)
  end

  def availability_code
    if has_event_happening_now?
      0
      # :busy
    else
      1
      # :available
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

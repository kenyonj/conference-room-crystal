require "http/client"

class ConferenceRoom::Calendar
  CALENDAR_IDS = {
    bender: ENV["BENDER_ID"],
    optimus: ENV["OPTIMUS_ID"],
    eve: ENV["EVE_ID"],
    walle: ENV["WALLE_ID"],
  }

  getter :name
  private getter busy_code = 0
  private getter available_code = 1

  def initialize(@name : Symbol)
  end

  def self.all
    CALENDAR_IDS.keys.map do |calendar_name|
      new(calendar_name)
    end
  end

  def availability_code
    if has_event_happening_now?
      busy_code
    else
      available_code
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

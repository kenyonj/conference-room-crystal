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
  private getter available_indefinitely : Int32 = 9.nines

  @events : Array(CalendarEvent)?

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

  def minutes_until_state_change
    if has_event_happening_now?
      minutes_until_free
    else
      minutes_until_busy
    end
  end

  private def has_event_happening_now?
    events.any? &.happening_now?
  end

  private def minutes_until_busy
    if future_events.empty?
      available_indefinitely
    else
      (future_events.first.start_time - Time.utc_now).total_minutes.ceil.to_i
    end
  end

  private def minutes_until_free
    MinutesUntilFreeCalculator.new(future_events).minutes_until_free
  end

  private def current_event
    events.find(&.happening_now?).not_nil!
  end

  private def future_events
    events.select do |event|
      event.start_time > Time.utc_now
    end
  end

  private def events
    @events ||= IcalResponse.parse(raw_events).sort_by &->earliest_first(CalendarEvent)
  end

  private def earliest_first(event)
    event.start_time
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

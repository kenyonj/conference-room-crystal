class ConferenceRoom::EventParser
  getter :raw_event

  def initialize(@raw_event : String)
  end

  def start_time
    parse_time("DTSTART")
  end

  def end_time
    parse_time("DTEND")
  end

  private def parse_time(field_name)
    Time.parse(value_from(field_name), "%Y%m%dT%k%M%SZ")
  end

  private def value_from(field_name)
    raw_event.each_line.find do |line|
      line.starts_with?(field_name)
    end.not_nil!.split(":").last
  end
end

class ConferenceRoom::MinutesUntilFreeCalculator
  private getter :events

  def initialize(@events : Array(CalendarEvent))
  end

  def minutes_until_free
    find_next_event_with_space_between(index: 0)
  end

  private def find_next_event_with_space_between(index)
    current_event = events[index]
    next_event = events[index + 1]?

    if next_event.nil?
      (current_event.end_time - Time.utc_now).total_minutes.ceil.to_i
    else
      if (next_event.start_time - current_event.end_time).total_minutes.to_i > 5
        (current_event.end_time - Time.utc_now).total_minutes.ceil.to_i
      else
        find_next_event_with_space_between(index + 1)
      end
    end
  end
end

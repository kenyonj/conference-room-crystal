class ConferenceRoom::MinutesUntilFreeCalculator
  private getter :events

  def initialize(@events : Array(CalendarEvent))
  end

  def minutes_until_free
    find_minutes_until_free(starting_with_event_at_index: 0)
  end

  private def find_minutes_until_free(starting_with_event_at_index index)
    current_event = events[index]
    next_event = events[index + 1]?

    if next_event.nil?
      minutes_until_event_ends(current_event)
    else
      if next_event_starts_very_soon_after?(current_event, next_event)
        find_minutes_until_free(index + 1)
      else
        minutes_until_event_ends(current_event)
      end
    end
  end

  private def next_event_starts_very_soon_after?(current_event, next_event)
    (next_event.start_time - current_event.end_time).total_minutes.to_i < 5
  end

  private def minutes_until_event_ends(event)
    (event.end_time - Time.utc_now).total_minutes.ceil.to_i
  end
end

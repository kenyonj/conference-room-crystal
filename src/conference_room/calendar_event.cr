class ConferenceRoom::CalendarEvent
  getter :start_time, :end_time

  def initialize(@start_time : Time, @end_time : Time)
    @start_time
    @end_time
  end

  def happening_now?
    now = Time.utc_now
    now >= start_time && now <= end_time
  end
end
